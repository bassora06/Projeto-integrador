#include <WiFi.h> // Biblioteca para uso de internet
#include <PubSubClient.h> // Biblioteca para uso do MQTT


// Declaração de variáveis dos sensores
const int PINO_TRIG_SENSOR_1 = 18; 
const int PINO_ECHO_SENSOR_1 = 19; 

const int PINO_TRIG_SENSOR_2 = 32; 
const int PINO_ECHO_SENSOR_2 = 35; 

const int PINO_TRIG_SENSOR_3 = 17; 
const int PINO_ECHO_SENSOR_3 = 16; 

// Vetores com as variáveis criadas para facilitar no uso delas
const int TRIGGERS[3] = {PINO_TRIG_SENSOR_1, PINO_TRIG_SENSOR_2, PINO_TRIG_SENSOR_3};
const int ECHOS[3] = {PINO_ECHO_SENSOR_1, PINO_ECHO_SENSOR_2, PINO_ECHO_SENSOR_3};

// Declaração de variaveis dos leds
const int LED_VERMELHO_1 = 23;
const int LED_VERMELHO_2 = 4;
const int LED_VERMELHO_3 = 21;

const int LED_VERDE_1 = 22;
const int LED_VERDE_2 = 0;
const int LED_VERDE_3 = 5;

// Vetores com as variáveis criadas dos leds para facilitar no uso delas
const int LED_VERMELHO[3] = {LED_VERMELHO_1, LED_VERMELHO_2, LED_VERMELHO_3};
const int LED_VERDE[3] = {LED_VERDE_1, LED_VERDE_2, LED_VERDE_3};

// Variaveis contendo as infos do wifi
const char* ssid = "Wokwi-GUEST"; // Nome da rede
const char* password =""; // Senha

// topico para receber informações do MQTT
#define TOPICO_SUBSCRIBE "PI-receber-de-informacoes"

// Topico para enviar informações do MQTT 
#define TOPICO_PUBLISH_VAGA1 "vaga1"
#define TOPICO_PUBLISH_VAGA2 "vaga2"
#define TOPICO_PUBLISH_VAGA3 "vaga3" 

// Coloquei as vagas dentro de um vetor para manipulalas no código mais facilmente
const int TOPICO_PUBLISH_VAGAS[3] = {TOPICO_PUBLISH_VAGA1, TOPICO_PUBLISH_VAGA2, TOPICO_PUBLISH_VAGA3};

// ID do broker
#define ID_MQTT  "PI_Cliente_MQTT"

// URL do broker a ser utilizada
const char* BROKER_MQTT = "broker.hivemq.com"; 

// Porta do broker
int BROKER_PORT = 1883;

WiFiClient espClient;
PubSubClient MQTT(espClient);


void setup() {
  config();
}

void loop() {

  Conecta_WiFi();

  delay(500);

  verifica_conexoes_wifi_mqtt();

  delay(500);

  vagas();

  MQTT.loop();

  delay(1000); 

}

void config(){
  Serial.begin(115200); // Melhor usar 115200 no ESP32 para evitar atrasos

  for(int i = 0; i < 3; i++){
    pinMode(TRIGGERS[i], OUTPUT);
    pinMode(ECHOS[i], INPUT);
    pinMode(LED_VERMELHO[i], OUTPUT);
    pinMode(LED_VERDE[i], OUTPUT);
  }

  init_wifi();
  init_mqtt();
}

void init_wifi() {

  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void Conecta_WiFi()
{
  if(WiFi.status()){
    Serial.println("Conectado");
  }else{
    Serial.println("Desconectado");
  }
  
}


void vagas(){

  for(int i = 0; i < 3; i++){
    digitalWrite(TRIGGERS[i], LOW);
    delayMicroseconds(2);
    digitalWrite(TRIGGERS[i], HIGH);
    delayMicroseconds(10);
    digitalWrite(TRIGGERS[i], LOW);

    // Usando pulseInLong() para maior estabilidade
    long duracao = pulseInLong(ECHOS[i], HIGH);

    float distancia = (duracao * 0.034) / 2;

    if(distancia > 150){
      digitalWrite(LED_VERDE[i], HIGH);
      digitalWrite(LED_VERMELHO[i], LOW);
      MQTT.publish(TOPICO_PUBLISH_VAGAS[i], "livre");
    }else{
      digitalWrite(LED_VERMELHO[i], HIGH);
      digitalWrite(LED_VERDE[i], LOW);
      MQTT.publish(TOPICO_PUBLISH_VAGAS[i], "ocupada");
    }
  }

}

void init_mqtt(void) 
{
    /* informa a qual broker e porta deve ser conectado */
    MQTT.setServer(BROKER_MQTT, BROKER_PORT); 
    /* atribui função de callback (função chamada quando qualquer informação do 
    tópico subescrito chega) */
    MQTT.setCallback(mqtt_callback);            
}

void mqtt_callback(char* topic, byte* payload, unsigned int length) 
{
    String msg;
 
    //obtem a string do payload recebido
    for(int i = 0; i < length; i++) 
    {
       char c = (char)payload[i];
       msg += c;
    }
    Serial.print("[MQTT] Mensagem recebida: ");
    Serial.println(msg);     
}

void reconnect_mqtt(void) 
{
    while (!MQTT.connected()) 
    {
        Serial.print("* Tentando se conectar ao Broker MQTT: ");
        Serial.println(BROKER_MQTT);
        if (MQTT.connect(ID_MQTT)) 
        {
            Serial.println("Conectado com sucesso ao broker MQTT!");
            MQTT.subscribe(TOPICO_SUBSCRIBE); 
        } 
        else
        {
            Serial.println("Falha ao reconectar no broker.");
            Serial.println("Havera nova tentatica de conexao em 2s");
            delay(2000);
        }
    }
}

void verifica_conexoes_wifi_mqtt(void)
{
    /* se não há conexão com o WiFI, a conexão é refeita */
    init_wifi(); 
    /* se não há conexão com o Broker, a conexão é refeita */
    if (!MQTT.connected()) 
        reconnect_mqtt(); 
} 
  

