package fatec.pi.rod.onbus.entity;

import org.eclipse.paho.client.mqttv3.*;

public class AwsInscricaoTopico {

    private final MqttClient mqttClient;

    Log log = new Log();

    public AwsInscricaoTopico(MqttClient client) {
        this.mqttClient = client;
    }

    /*
     * Inscreve-se em um tópico MQTT e processa a primeira mensagem recebida.
     *
     * @param topic Tópico a ser assinado
     * @return A string recebida como payload (da primeira mensagem recebida)
     * @throws Exception Em caso de erro de inscrição ou conexão
     */

    public String inscreverTopico(String topic) throws Exception {
        final String[] receivedPayload = {null}; // Array para "simular" variável mutável

        // Criar listener de mensagens (sem lambda)
        IMqttMessageListener listener = new IMqttMessageListener() {
            @Override
            public void messageArrived(String t, MqttMessage message) {
                String payload = new String(message.getPayload());
                log.logMensagem("Mensagem recebida no tópico %s: %s", t, payload);
                receivedPayload[0] = payload;  // Armazena o valor para retorno
            }
        };

        mqttClient.subscribe(topic, listener);

        // Aguardar até receber a mensagem (com timeout simples de 10s)
        int tentativas = 0;
        while (receivedPayload[0] == null && tentativas < 100) {
            Thread.sleep(100); // Espera 100 ms
            tentativas++;
        }

        if (receivedPayload[0] == null) {
            throw new RuntimeException("⏰ Timeout ao aguardar mensagem no tópico: " + topic);
        }

        return receivedPayload[0];
    }
}


