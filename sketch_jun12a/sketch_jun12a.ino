#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <ESP8266WiFi.h>
#include <DHT.h>
#include <PubSubClient.h>

// Configuration
#define DHTPIN 14     // D5
//#define DHTPIN_2 12 // D6

#define DHTTYPE DHT22
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define WIFI_SSID "Bbox-54ECD2D6"
#define WIFI_PASSWORD "9TbHnuMA13vmtDn1ru"

const char* mqtt_host = "192.168.1.129";
const char* mqtt_user = "Brazil";
const char* mqtt_password = "password";
const int mqtt_port = 1883; 

WiFiClient espClient;
PubSubClient client(espClient);

DHT dht(DHTPIN, DHTTYPE);
//DHT dht2(DHTPIN_2, DHTTYPE);

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);

void setup() {
  Serial.begin(115200);
  pinMode(2, OUTPUT);
  dht.begin();
//dht2.begin();

  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) { for(;;); }
  
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  client.setServer(mqtt_host, mqtt_port);
}

void loop() {
  // Gestion Wi-Fi et MQTT
  if (WiFi.status() == WL_CONNECTED) {
    if (!client.connected()) {
      if (client.connect("ESP8266Client", mqtt_user, mqtt_password)) {
          Serial.println("Connecté avec authentification !");
      } else {
          Serial.println("Échec connexion, vérifiez mot de passe");
      }
    }
    client.loop();
  }

  float h = dht.readHumidity();
  float t = dht.readTemperature();

//float h2 = dht2.readHumidity();
//float t2 = dht2.readTemperature();

  digitalWrite(2, ((millis() / 1000) % 2 == 0) ? LOW : HIGH);

  // --- Affichage Écran ---
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(WHITE);

  // Ligne 1 : État Wi-Fi
  display.setCursor(0, 0);
  display.print("WiFi : ");
  display.print(WiFi.status() == WL_CONNECTED ? "ON " : "OFF");
  if (WiFi.status() == WL_CONNECTED) {
    long rssi = WiFi.RSSI();
    display.print(rssi > -60 ? " ||||" : " ||");
  }

  // Ligne 2 : État Serveur MQTT
  display.setCursor(0, 10);
  display.print("Server : ");
  display.print(client.connected() ? "ON" : "OFF");

  // Corps : Données
  display.setCursor(0, 25);
  display.setTextSize(2);
  if (!isnan(h) && !isnan(t)) {
    display.print("T:"); display.print(t, 1); display.println("C");
    display.print("H:"); display.print(h, 1); display.println("%");
    
    // Envoi MQTT toutes les 5 secondes
    if (client.connected() && (millis() % 5000 < 500)) {
      client.publish("dht22-t1", String(t).c_str());
      client.publish("dht22-h1", String(h).c_str());

//    client.publish("maison/capteur2/temp", String(t2).c_str());
    }
  }

  display.display();
  delay(500);
}