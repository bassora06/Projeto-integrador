package fatec.pi.rod.onbus.entity;

import org.eclipse.paho.client.mqttv3.*;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;

import javax.net.ssl.SSLSocketFactory;
import java.time.Instant;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class MqttService {

    private static final String BROKER_URL = "ssl://a2ve1hemun842j-ats.iot.us-east-2.amazonaws.com:8883";
    private static final String CLIENT_ID = "spring-client-" + UUID.randomUUID();
    private static final String CA_CERT = "certs/AmazonRootCA1.pem";
    private static final String CLIENT_CERT = "certs/certificate.pem.crt";
    private static final String PRIVATE_KEY = "certs/private_pkcs8.pem";

    private final Map<String, VagaStatus> cache = new ConcurrentHashMap<>();
    private MqttClient mqttClient;
    private final Log log = new Log();

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

            for (String topico : fatec.pi.rod.onbus.entity.Topicos.TODOS) {
                cache.put(topico, new VagaStatus(false, null));
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
            boolean ocupada = payload.equalsIgnoreCase("1") ||
                    payload.equalsIgnoreCase("true") ||
                    payload.equalsIgnoreCase("ocupada") ||
                    payload.equalsIgnoreCase("ocupado");

            boolean livre = payload.equalsIgnoreCase("0") ||
                    payload.equalsIgnoreCase("false") ||
                    payload.equalsIgnoreCase("livre") ||
                    payload.equalsIgnoreCase("desocupado");

            if (livre) {
                cache.put(t, new VagaStatus(false, null, false)); // reset expirada
            } else {
                VagaStatus atual = cache.get(t);
                boolean expirada = atual != null && atual.expirada();
                cache.put(t, new VagaStatus(true, Instant.now(), expirada));
            }

            System.out.println("📨 Mensagem recebida em " + t + ": '" + payload + "'");
        };
    }


    public Map<String, VagaStatus> getCache() {
        return cache;
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

