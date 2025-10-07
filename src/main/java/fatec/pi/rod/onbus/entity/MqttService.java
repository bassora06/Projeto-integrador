package fatec.pi.rod.onbus.entity;

import org.eclipse.paho.client.mqttv3.*;
import org.springframework.stereotype.Component;
import jakarta.annotation.PostConstruct;
import fatec.pi.rod.onbus.repository.VagaRepository; // Importe o repositório

import javax.net.ssl.SSLSocketFactory;
import java.time.Instant;
import java.util.UUID;

@Component
public class MqttService {

    private static final String BROKER_URL = "ssl://a2ve1hemun842j-ats.iot.us-east-2.amazonaws.com:8883";
    private static final String CLIENT_ID = "spring-client-" + UUID.randomUUID();
    private static final String CA_CERT = "certs/AmazonRootCA1.pem";
    private static final String CLIENT_CERT = "certs/certificate.pem.crt";
    private static final String PRIVATE_KEY = "certs/private_pkcs8.pem";

    private final VagaRepository vagaRepository; // Injeção de dependência do repositório
    private MqttClient mqttClient;
    private final Log log = new Log();

    // Construtor para injeção de dependência
    public MqttService(VagaRepository vagaRepository) {
        this.vagaRepository = vagaRepository;
    }

    @PostConstruct
    public void init() {
        try {
            SSLSocketFactory sslSocketFactory = AwsLeituraCerts.getSocketFactory(CA_CERT, CLIENT_CERT, PRIVATE_KEY);

            MqttConnectOptions options = new MqttConnectOptions();
            options.setSocketFactory(sslSocketFactory);
            options.setCleanSession(true);
            options.setKeepAliveInterval(60);
            options.setAutomaticReconnect(true);

            mqttClient = new MqttClient(BROKER_URL, CLIENT_ID);
            mqttClient.connect(options);

            log.logSucesso("Conectado ao AWS IoT Core!");

            // Se inscreve nos tópicos de vagas
            for (String topico : Topicos.TODOS) {
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

            boolean ocupada = payload.equalsIgnoreCase("1") || payload.equalsIgnoreCase("ocupada");
            boolean livre = payload.equalsIgnoreCase("0") || payload.equalsIgnoreCase("livre");

            // Busca o documento da vaga no MongoDB ou cria um novo se não existir
            VagaDocument vagaDoc = vagaRepository.findById(t).orElse(new VagaDocument(t, StatusVaga.LIVRE, null, false));

            if (livre) {
                vagaDoc.setStatus(StatusVaga.LIVRE);
                vagaDoc.setInicioOcupacao(null);
                vagaDoc.setExcedida(false); // Reseta o status de excedida
            } else if (ocupada) {
                // Só atualiza o início da ocupação se a vaga estava livre antes
                if (vagaDoc.getStatus() == StatusVaga.LIVRE) {
                    vagaDoc.setInicioOcupacao(Instant.now());
                }
                vagaDoc.setStatus(StatusVaga.OCUPADA);
            }

            // Salva o estado atualizado no MongoDB
            vagaRepository.save(vagaDoc);
        };
    }
}
