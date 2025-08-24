package fatec.pi.rod.onbus.entity;

import fatec.pi.rod.onbus.repository.VagaRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor; // Adicione esta importação
import org.eclipse.paho.client.mqttv3.*;
import org.springframework.stereotype.Component;

import javax.net.ssl.SSLSocketFactory;
import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Component
@RequiredArgsConstructor // <-- ADICIONE esta anotação para injeção de dependência
public class MqttService {

    private static final String BROKER_URL = "ssl://a2ve1hemun842j-ats.iot.us-east-2.amazonaws.com:8883";
    private static final String CLIENT_ID = "spring-client-" + UUID.randomUUID();
    private static final String CA_CERT = "certs/AmazonRootCA1.pem";
    private static final String CLIENT_CERT = "certs/certificate.pem.crt";
    private static final String PRIVATE_KEY = "certs/private_pkcs8.pem";

    private final VagaRepository vagaRepository; // <-- TORNE A VARIÁVEL 'final'
    private MqttClient mqttClient;
    private final Log log = new Log();

    @PostConstruct
    public void init() {
        try {
            // 1. Cria o SocketFactory usando sua classe de leitura de certificados
            SSLSocketFactory socketFactory = AwsLeituraCerts.getSocketFactory(CA_CERT, CLIENT_CERT, PRIVATE_KEY);

            // 2. Cria e configura as opções de conexão MQTT
            MqttConnectOptions options = new MqttConnectOptions();
            options.setSocketFactory(socketFactory);

            // 3. Inicializa o cliente MQTT
            mqttClient = new MqttClient(BROKER_URL, CLIENT_ID);

            // 4. Conecta usando as opções que você acabou de criar
            mqttClient.connect(options);
            log.logSucesso("Conectado ao AWS IoT Core!");

            // Inicializa as vagas no banco de dados se não existirem
            for (String topico : Topicos.TODOS) {
                vagaRepository.findById(topico).orElseGet(() ->
                        vagaRepository.save(new VagaDocument(topico, StatusVaga.LIVRE, null, false))
                );
                mqttClient.subscribe(topico, criarListener(topico));
            }

        } catch (Exception e) {
            log.logErro("Erro ao conectar ao AWS IoT Core: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private IMqttMessageListener criarListener(String topic) {
        return (t, msg) -> {
            String payload = new String(msg.getPayload());
            log.logInfo("📨 Mensagem recebida em " + t + ": '" + payload + "'");

            boolean ocupadaMsg = payload.equalsIgnoreCase("1") || payload.equalsIgnoreCase("ocupada");
            boolean livreMsg = payload.equalsIgnoreCase("0") || payload.equalsIgnoreCase("livre");

            // Busca o documento atual no MongoDB
            Optional<VagaDocument> vagaOpt = vagaRepository.findById(t);
            if (vagaOpt.isPresent()) {
                VagaDocument vaga = vagaOpt.get();
                if (livreMsg) {
                    vaga.setStatus(StatusVaga.LIVRE);
                    vaga.setInicioOcupacao(null);
                    vaga.setExcedida(false); // Reseta o status de excedida
                } else if (ocupadaMsg && vaga.getStatus() == StatusVaga.LIVRE) {
                    // Só marca como ocupada se antes estava livre, para não sobrescrever o timestamp
                    vaga.setStatus(StatusVaga.OCUPADA);
                    vaga.setInicioOcupacao(Instant.now());
                }
                vagaRepository.save(vaga); // Salva o estado atualizado no MongoDB
            }
        };
    }

    public void publicarTimeout(String topic) {
        try {
            String timeoutTopic = topic + "/timeout";
            String payload = "excedido";

            MqttMessage message = new MqttMessage(payload.getBytes());
            message.setQos(1);
            message.setRetained(false);

            if (!mqttClient.isConnected()) mqttClient.reconnect();

            mqttClient.publish(timeoutTopic, message);
            log.logTemporizador("Timeout publicado em %s", timeoutTopic);

        } catch (Exception e) {
            log.logErro("Erro ao publicar timeout: " + e.getMessage());
        }
    }
}