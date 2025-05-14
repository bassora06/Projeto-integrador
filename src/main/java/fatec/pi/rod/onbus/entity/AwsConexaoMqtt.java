package fatec.pi.rod.onbus.entity;

import org.eclipse.paho.client.mqttv3.IMqttMessageListener;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;
import java.time.Duration;
import java.time.Instant;
import java.util.Arrays;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import org.eclipse.paho.client.mqttv3.MqttClient;

import javax.net.ssl.SSLSocketFactory;

@Component
public class AwsConexaoMqtt {

    private static final String BROKER_URL = "ssl://a2ve1hemun842j-ats.iot.us-east-2.amazonaws.com:8883";
    private static final String CLIENT_ID = "spring-client-" + UUID.randomUUID();

    private static final String CA_CERT = "certs/AmazonRootCA1.pem";
    private static final String CLIENT_CERT = "certs/certificate.pem.crt";
    private static final String PRIVATE_KEY = "certs/private_pkcs8.pem";

    private static final String TOPICO_SUBSCRIBE_VAGA1 = "vaga1";
    private static final String TOPICO_SUBSCRIBE_VAGA2 = "vaga2";
    private static final String TOPICO_SUBSCRIBE_VAGA3 = "vaga3";

    private static final Duration LIMITE = Duration.ofMinutes(1);

    Log log = new Log();

    private final Map<String, VagaStatus> cache = new ConcurrentHashMap<>();

    private MqttClient mqttClient;

    @PostConstruct
    public void init() {
        try {
            SSLSocketFactory sslSocketFactory = AwsLeituraCerts.getSocketFactory(CA_CERT, CLIENT_CERT, PRIVATE_KEY);

            MqttConnectOptions options = new MqttConnectOptions();
            options.setSocketFactory(sslSocketFactory);
            options.setCleanSession(true);
            options.setKeepAliveInterval(60); // Adicionar keep-alive para manter a conexão
            options.setAutomaticReconnect(true); // Habilitar reconexão automática

            mqttClient = new MqttClient(BROKER_URL, CLIENT_ID, null);
            mqttClient.connect(options);

            log.logSucesso("Conectado ao AWS IoT Core!");

            AwsInscricaoTopico awsIncricaoTopico = new AwsInscricaoTopico(mqttClient);

            // Inicializar cache com vagas livres
            cache.put(TOPICO_SUBSCRIBE_VAGA1, new VagaStatus(false, null));
            cache.put(TOPICO_SUBSCRIBE_VAGA2, new VagaStatus(false, null));
            cache.put(TOPICO_SUBSCRIBE_VAGA3, new VagaStatus(false, null));

            String vaga1 = awsIncricaoTopico.inscreverTopico(TOPICO_SUBSCRIBE_VAGA1);
            String vaga2 = awsIncricaoTopico.inscreverTopico(TOPICO_SUBSCRIBE_VAGA1);
            String vaga3 = awsIncricaoTopico.inscreverTopico(TOPICO_SUBSCRIBE_VAGA1);

            log.logMensagem("Valor vaga 1: ", vaga1);
            log.logMensagem("Valor vaga 2: ", vaga2);
            log.logMensagem("Valor vaga 3: ", vaga3);

        } catch (Exception e) {
            log.logErro("❌ Erro ao conectar ao AWS IoT Core: " + e.getMessage());
            e.printStackTrace();
        }
    }

//    private String subscribeTopic(String topic) {
//        try {
//            mqttClient.subscribe(topic, new IMqttMessageListener() {
//                @Override
//                public void messageArrived(String t, MqttMessage msg) {
//                    String payload = new String(msg.getPayload());
//
//                    // Logs de depuração
//                    System.out.println("DEBUG: Payload bruto recebido para " + t + ": '" +
//                            Arrays.toString(msg.getPayload()) + "'");  // Mostra bytes brutos
//                    System.out.println("DEBUG: Payload como string: '" + payload + "'");
//                    System.out.println("DEBUG: Comprimento da string: " + payload.length());
//                    System.out.println("DEBUG: Código dos caracteres: " +
//                            payload.chars().mapToObj(c -> String.format("%02X ", c))
//                                    .collect(Collectors.joining()));
//
//                    boolean ocupada = payload.equalsIgnoreCase("1") ||
//                            payload.equalsIgnoreCase("true") ||
//                            payload.equalsIgnoreCase("ocupada") ||
//                            payload.equalsIgnoreCase("ocupado");
//
//                    System.out.println("Debug interpretado como ocupada: " + ocupada);
//
//                    if (ocupada) {
//                        cache.put(t, new VagaStatus(true, Instant.now()));
//                        System.out.printf("📥 %s = %s (ocupada, início: %s)%n", t, payload,
//                                cache.get(t).inicioOcupacao());
//                    } else {
//                        cache.put(t, new VagaStatus(false, null));
//                        System.out.printf("📥 %s = %s (livre)%n", t, payload);
//                    }
//                }
//            });
//
//            System.out.println("✅ Inscrito no tópico: " + topic);
//
//            return topic;
//        } catch (Exception e) {
//            System.err.println("❌ Erro ao inscrever no tópico " + topic + ": " + e.getMessage());
//            e.printStackTrace();
//        }
//    }


    @Scheduled(fixedRate = 60_000)
    public void verificarExpiracoes() {
        System.out.println("🔍 Verificando expiração de vagas...");

        Instant agora = Instant.now();
        cache.forEach((topic, status) -> {
            if (status.ocupada() && status.inicioOcupacao() != null) {
                Duration tempoOcupado = Duration.between(status.inicioOcupacao(), agora);
                System.out.printf("🕒 %s ocupada há %d minutos%n", topic, tempoOcupado.toMinutes());

                if (tempoOcupado.compareTo(LIMITE) > 0) {
                    enviarTimeout(topic);
                    cache.put(topic, new VagaStatus(false, null)); // libera a vaga
                }
            }
        });
    }

    private void enviarTimeout(String topic) {
        try {
            String timeoutTopic = topic + "/timeout";      // ex.: vaga1/timeout
            String payload = "excedido";

            MqttMessage message = new MqttMessage(payload.getBytes());
            message.setQos(1);  // Garantir entrega pelo menos uma vez
            message.setRetained(false);

            // Verificar se o cliente está conectado
            if (!mqttClient.isConnected()) {
                log.logAtencao("Cliente MQTT desconectado, tentando reconectar...");
                mqttClient.reconnect();
            }

            mqttClient.publish(timeoutTopic, message);
            log.logTemporizador("Timeout publicado em %s%n", timeoutTopic);
        } catch (Exception e) {
            log.logErro("❌ Erro ao publicar timeout: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Classe interna para armazenar o status da vaga
    public record VagaStatus(boolean ocupada, Instant inicioOcupacao) {}
    

}