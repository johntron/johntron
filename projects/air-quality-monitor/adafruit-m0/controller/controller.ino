#include "secrets.h"
#include "src/wifi/wifi.h"
#include "src/wifi/print.h"
#include "src/mqtt/mqtt_client.h"
#include "src/adafruit_pmsa003i/particle_sensor.h"
#include "src/adafruit_bme688/gas_sensor.h"
#include "secrets.h"

#define DEBUG(msg) \
    Serial.println(msg)

ParticleSensor particle;
GasSensor gas;
MQTT_Client mqtt;
Wifi wifi;

void setup() {
    Serial.begin(9600);
//    while (!Serial) {
//        ; // wait for serial port to connect. Needed for native USB port only
//    }
    particle.connect();
    gas.connect();
    wifi.connect(SECRET_SSID, SECRET_PASS);
    mqtt.config();
}

void loop() {
    ParticleReadings particleReadings;
    GasReadings gasReadings;

    particle.read(&particleReadings);

    if (gas.read(&gasReadings)) {
        DEBUG("Read gas sensor");
        Serial.print("Temperature: ");
        Serial.println(gasReadings.temperature);
        Serial.print("Humidity: ");
        Serial.println(gasReadings.humidity);
        Serial.print("Pressure: ");
        Serial.println(gasReadings.pressure);
        Serial.print("Gas resistance: ");
        Serial.println(gasReadings.gas_resistance);
    }
//    printCurrentNet();
    mqtt.state(&particleReadings, &gasReadings);
    delay(500);
}
