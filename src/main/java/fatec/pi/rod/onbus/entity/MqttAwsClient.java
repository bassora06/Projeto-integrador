package fatec.pi.rod.onbus.entity;

import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

import org.eclipse.paho.client.mqttv3.MqttClient;


import javax.net.ssl.*;

@Component
public class MqttAwsClient {

    private static final String BROKER_URL = "ssl://a2ve1hemun842j-ats.iot.us-east-2.amazonaws.com:8883";
    private static final String CLIENT_ID = "spring-client-" + UUID.randomUUID();

    private static final String CA_CERT = "certs/AmazonRootCA1.pem";
    private static final String CLIENT_CERT = "certs/certificate.pem.crt";
    private static final String PRIVATE_KEY = "certs/private_pkcs8.pem";

    private static final String TOPICO_SUBSCRIBE_VAGA1 = "vaga1";
    private static final String TOPICO_SUBSCRIBE_VAGA2 = "vaga2";
    private static final String TOPICO_SUBSCRIBE_VAGA3 = "vaga3";

    private MqttClient mqttClient;

    @PostConstruct
    public void init() {
        try {

            String mensagem;

            SSLSocketFactory sslSocketFactory = AwsIotSslUtil.getSocketFactory(CA_CERT, CLIENT_CERT, PRIVATE_KEY);

            MqttConnectOptions options = new MqttConnectOptions();
            options.setSocketFactory(sslSocketFactory);
            options.setCleanSession(true);

            mqttClient = new MqttClient(BROKER_URL, CLIENT_ID, null);
            mqttClient.connect(options);

            System.out.println("✅ Conectado ao AWS IoT Core!");


            String vaga1 = subscribeTopic(TOPICO_SUBSCRIBE_VAGA1);
            String vaga2 = subscribeTopic(TOPICO_SUBSCRIBE_VAGA2);
            String vaga3 = subscribeTopic(TOPICO_SUBSCRIBE_VAGA3);



        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String subscribeTopic(String TOPIC) {
        // Usando AtomicReference para armazenar a mensagem
        AtomicReference<String> mensagemRecebida = new AtomicReference<>(null);

        try {
            mqttClient.subscribe(TOPIC, (topic, msg) -> {
                // Armazenando a mensagem recebida na variável AtomicReference
                String mensagem = new String(msg.getPayload());
                mensagemRecebida.set(mensagem); // Atualizando o valor da mensagem recebida

                switch (TOPIC) {
                    case "vaga1":
                        System.out.println("📥 Mensagem recebida da vaga 1 : " + mensagem);
                        break;  // Certifique-se de usar o 'break' para evitar a execução dos outros casos
                    case "vaga2":
                        System.out.println("📥 Mensagem recebida da vaga 2 : " + mensagem);
                        break;  // Certifique-se de usar o 'break' para evitar a execução dos outros casos
                    case "vaga3":
                        System.out.println("📥 Mensagem recebida da vaga 3 : " + mensagem);
                        break;  // Certifique-se de usar o 'break' para evitar a execução dos outros casos
                    default:
                        System.out.println("📥 Mensagem recebida de um tópico desconhecido: " + mensagem);
                        break;
                }

            });

            // Esperar algum tempo para garantir que a mensagem seja recebida
            Thread.sleep(1000);  // Ajuste o tempo conforme necessário

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Retornando a mensagem que foi recebida
        return mensagemRecebida.get();
    }
}

