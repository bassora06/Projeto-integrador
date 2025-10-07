#include <WiFi.h> // Biblioteca para uso de internet
#include <PubSubClient.h> // Biblioteca para uso do MQTT
#include <WiFiClientSecure.h> // Biblioteca usada para a conexão usando criptografia


// Declaração de variáveis dos sensores
const int PINO_TRIG_SENSOR_1 = 18; 
const int PINO_ECHO_SENSOR_1 = 19; 

const int PINO_TRIG_SENSOR_2 = 32; 
const int PINO_ECHO_SENSOR_2 = 35; 

const int PINO_TRIG_SENSOR_3 = 27; 
const int PINO_ECHO_SENSOR_3 = 26; 

// Vetores com as variáveis criadas para facilitar no uso delas
const int TRIGGERS[3] = {PINO_TRIG_SENSOR_1, PINO_TRIG_SENSOR_2, PINO_TRIG_SENSOR_3};
const int ECHOS[3] = {PINO_ECHO_SENSOR_1, PINO_ECHO_SENSOR_2, PINO_ECHO_SENSOR_3};

// Variaveis contendo as infos do wifi
const char* ssid = "LIA"; // Nome da rede
const char* password ="Lucas1974"; // Senha

// topico para receber informações do MQTT
// #define TOPICO_SUBSCRIBE "PI-receber-de-informacoes"

// Topico para enviar informações do MQTT 
const char* TOPICO_PUBLISH_VAGA1 = "vaga1";
const char* TOPICO_PUBLISH_VAGA2 = "vaga2";
const char* TOPICO_PUBLISH_VAGA3 = "vaga3";

// Coloquei as vagas dentro de um vetor para manipulalas no código mais facilmente
const char* TOPICO_PUBLISH_VAGAS[3] = {TOPICO_PUBLISH_VAGA1, TOPICO_PUBLISH_VAGA2, TOPICO_PUBLISH_VAGA3};

// ID do broker
#define ID_MQTT  "PI_Cliente_MQTT"

// URL do broker a ser utilizada
const char* BROKER_MQTT = "a2ve1hemun842j-ats.iot.us-east-2.amazonaws.com"; 

// Porta do broker
int BROKER_PORT = 8883;

// Credenciais (coloque os arquivos baixados da AWS IoT)
const char* certificate = R"KEY(
-----BEGIN CERTIFICATE-----
MIIDWjCCAkKgAwIBAgIVAPAvjWbp1HeCcfIrauqgQgCl99ivMA0GCSqGSIb3DQEB
CwUAME0xSzBJBgNVBAsMQkFtYXpvbiBXZWIgU2VydmljZXMgTz1BbWF6b24uY29t
IEluYy4gTD1TZWF0dGxlIFNUPVdhc2hpbmd0b24gQz1VUzAeFw0yNTAzMjExNTE2
NDNaFw00OTEyMzEyMzU5NTlaMB4xHDAaBgNVBAMME0FXUyBJb1QgQ2VydGlmaWNh
dGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDrcHc0BgPaq4nfhex8
fRwTWBcajDviYTlMt9qpiCXFhcf70MaFMpakOcXwhLzaY6DxIXrC+9SfKUg3PoUB
J8JaqFn3gree0j/lW7WeZomOenl384bXQQE801Y5gVuUnkYnovqFz83b9XEdJEQ0
5p3pLpJjvC3ErUX3aZvorqDnPSJFpZmbxNXHgyhOnxLievt5oY0XZezY7uQHsZuD
UqdffwM+yD7QJzqCjZb5BDktVPziFf9GSI4bbd+8VFvB11sbyQxKHNCGxxZG9QCS
Kew/6pXz9mU25gxAlP5trydmYL0lhpWlOG2niBqiMHPAelUdmzzLc6WJyzCngqbn
mq3vAgMBAAGjYDBeMB8GA1UdIwQYMBaAFGjsUBVF2IuHYfzYauLCNT9s5tImMB0G
A1UdDgQWBBRG6RAqoZWWySew50I2Ij+1m2nD5zAMBgNVHRMBAf8EAjAAMA4GA1Ud
DwEB/wQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAFFxWlhSNFedQ9DFSl6uxlLrL
Qp72hsTbUeV8VenEm1rpPzBsWPOblH93szINGWokavPLOp31p+F2X3DD3sXAYBXN
2ZS0LVX4Y9JHk15ud1PaiCUgSuJ4n8N4wfPctymvCsfKQNK8FqTWqU8ksfkT50AP
9L5xqqhnYWPG7CQ2tg9I2j/lxr6WZzJBgP6jZ4M1bDvI0Oalq+H4plAE5nSHWnEP
yoIeBdFr8HHabagMWu9FYRQ2LiEU9dnWlwwrTV/9kKCeqEyfIsU4jeFJc8hu3l9O
rSs2QEM3xtQIDWznOzL4ZgzduPa0m9hHtKBj/sAPjgJBJ1LWxEJMK3ZVSQAoSg==
-----END CERTIFICATE-----
)KEY";

const char* privateKey = R"KEY(
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA63B3NAYD2quJ34XsfH0cE1gXGow74mE5TLfaqYglxYXH+9DG
hTKWpDnF8IS82mOg8SF6wvvUnylINz6FASfCWqhZ94K3ntI/5Vu1nmaJjnp5d/OG
10EBPNNWOYFblJ5GJ6L6hc/N2/VxHSRENOad6S6SY7wtxK1F92mb6K6g5z0iRaWZ
m8TVx4MoTp8S4nr7eaGNF2Xs2O7kB7Gbg1KnX38DPsg+0Cc6go2W+QQ5LVT84hX/
RkiOG23fvFRbwddbG8kMShzQhscWRvUAkinsP+qV8/ZlNuYMQJT+ba8nZmC9JYaV
pThtp4gaojBzwHpVHZs8y3Olicswp4Km55qt7wIDAQABAoIBACr+nsYhUxLbwJHR
Ix6YukfODmoKseTlXFFmQcgz1LH9fEfAGIC6fEgBRORnWRWInBtswb5ZvrpSD54H
DMLpP9TOaZ+Jf37BZmm8Fa6Xiwc51nTRRA6LEG7LKTPXK6I4RRd368gD6tQAPmfT
96CxfKTYnGMaOkFwYxaLcq1LNpcDeU5YovxVl7hjqglTOleowubTdgDfJ2O9Pyw9
z4EOeURxHwjHHuwJXK3ulSsrx5tcqHEMRLwg6dEkf7I4MzcRBFnFpjg8HYquFizc
K3wovxD2SqXvBgj3R4QMm9qP9r+RWS5CA0DIJZVf9ZGW4YmkR0TnRdUqul8CwMTt
SaxxSgECgYEA+wzOueRW4uTd0ShAI0e5cdJsOt4GPt0UNs1TqLU7hvh2aB/8IyrT
nPyEvUpEcGRJyQjHcK8eWfY7qDd72C/u+QKNRO/jP68N3EG8/Zvc2Xm6xcKh190a
WR1UVtKfqM2gZcGGaRL+xeUtWJow5OKCsNWnUwChDbrlNtHinq89tw0CgYEA8BTc
qeCoYtfK74OFMGX71fubYNkXoZnfZ+Qvfncz/yRqafemS9W/lCB9Jct6P7vyer4r
LpT9laQ0mDsYDjH9BBemj0T0ppne2vvtkNDn3uMpvylAciR2eF8OsFnH7+PfTHJ6
UtfMr1d0iNfRSbjhYFHou1KuqsQCC3eMjdSI+esCgYEAsCJAN7O4MeAYsFHpDdeY
h/716Cc1go1hTUGpXEgqx3syt8MZByNY7F9OUe/1LFVwXxdFtg1m4f8bw92Jihe3
NgVQT/luGpQayVll2xirTflVzMHNAsIhZjxpm7CSS8BYtIueXcHx9a3grrUfcLZq
st5zUoyycguaHWgL8wFH71ECgYBtW1NYHfkVbO4HQ4U7kniv87fG2ZwmBAz7Kblo
hautoEzIkAGzsV1ef54BxTmeJmJA/rZ0tXD85JsAbIp8jNCPOKapw+McsCIO5YpE
2KOFpzuw032DgJBmLAZo1bx4zPc9vzdw3NNjWxa97nBqgEhIs4arLPJa3oV/66ie
Qh1SmQKBgF929Q8Ki64EAyjlyW1R74JOWNeqfS2CDLnFhOgqEONPewnCyFWSkzBB
GG6Ea8ltuNVmCP1qh5waGt5FTCEA0djS8/CNQznUbIvEvPOvD+OMUUUBWuYPwvjw
fikj0J3cGmHM2TcH8EUIQjSiCmya8uVxvjFiRQSoC2hhfbRQ8u+8
-----END RSA PRIVATE KEY-----
)KEY";

const char* rootCA = R"KEY(
-----BEGIN CERTIFICATE-----
MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
rqXRfboQnoZsG4q5WTP468SQvvG5
-----END CERTIFICATE-----
)KEY";

WiFiClientSecure espClient;
PubSubClient client(espClient);


void setup() {
  config();
}

void loop() {

  if (!client.connected()) {
    connectAWS();
  }
  
  client.loop();

  vagas();

  delay(3000); 

}

void config(){
  Serial.begin(115200); // Melhor usar 115200 no ESP32 para evitar atrasos

  for(int i = 0; i < 3; i++){
    pinMode(TRIGGERS[i], OUTPUT);
    pinMode(ECHOS[i], INPUT);
  }

  connectWifi();

}

void connectWifi() {

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

}

void connectAWS() {
    espClient.setCACert(rootCA);
    espClient.setCertificate(certificate);
    espClient.setPrivateKey(privateKey);
    client.setServer(BROKER_MQTT, BROKER_PORT);

    while (!client.connected()) {
        Serial.print("Conectando ao AWS IoT...");
        if (client.connect("ESP32_HIDRA")) {
            Serial.println("Conectado!");
        } else {
            Serial.print("Falha, rc=");
            Serial.print(client.state());
            Serial.println(" Tentando novamente...");
            delay(5000);
        }
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
      Serial.print("Vaga ");
      Serial.print(i);
      Serial.println(" Livre");
      client.publish(TOPICO_PUBLISH_VAGAS[i], "livre");
    }else{
      Serial.print("Vaga ");
      Serial.print(i);
      Serial.println(" Ocupada");
      client.publish(TOPICO_PUBLISH_VAGAS[i], "ocupada");
    }
  }
  Serial.println("");
}

  

