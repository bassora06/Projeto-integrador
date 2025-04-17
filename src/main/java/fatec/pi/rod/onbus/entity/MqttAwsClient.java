package fatec.pi.rod.onbus.entity;

import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;
import java.util.UUID;
import org.eclipse.paho.client.mqttv3.MqttClient;


import javax.net.ssl.*;

@Component
public class MqttAwsClient {

    private static final String BROKER_URL = "ssl://a2ve1hemun842j-ats.iot.us-east-2.amazonaws.com:8883";
    private static final String CLIENT_ID = "spring-client-" + UUID.randomUUID();

    private static final String CA_CERT = "certs/AmazonRootCA1.pem";
    private static final String CLIENT_CERT = "certs/certificate.pem.crt";
    private static final String PRIVATE_KEY = "certs/private.pem.key";

    private static final String TOPICO_SUBSCRIBE_VAGA1 = "vaga1";
    private static final String TOPICO_SUBSCRIBE_VAGA2 = "vaga2";
    private static final String TOPICO_SUBSCRIBE_VAGA3 = "vaga3";

    private MqttClient mqttClient;

    @PostConstruct
    public void init() {
        try {
            SSLSocketFactory sslSocketFactory = AwsIotSslUtil.getSocketFactory(CA_CERT, CLIENT_CERT, PRIVATE_KEY);

            MqttConnectOptions options = new MqttConnectOptions();
            options.setSocketFactory(sslSocketFactory);
            options.setCleanSession(true);

            mqttClient = new MqttClient(BROKER_URL, CLIENT_ID, null);
            mqttClient.connect(options);

            System.out.println("✅ Conectado ao AWS IoT Core!");


            subscribeTopic(TOPICO_SUBSCRIBE_VAGA1);
            subscribeTopic(TOPICO_SUBSCRIBE_VAGA2);
            subscribeTopic(TOPICO_SUBSCRIBE_VAGA3);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void subscribeTopic(String TOPIC){
        try {
            mqttClient.subscribe(TOPIC, (topic, msg) -> {
                System.out.println("📥 Mensagem recebida: " + new String(msg.getPayload()));
            });
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}

