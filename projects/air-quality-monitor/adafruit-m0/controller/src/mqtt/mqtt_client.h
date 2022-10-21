#ifndef AIR_QUALITY_MONITOR_CLIENT_H
#define AIR_QUALITY_MONITOR_CLIENT_H

#include "Adafruit_MQTT_Client.h"
#include <WiFi101.h>
#include "../adafruit_pmsa003i/readings.h"
#include "../adafruit_bme688/readings.h"

#ifdef MAXBUFFERSIZE
#undef MAXBUFFERSIZE
#define MAXBUFFERSIZE (50)
#endif

#define BROKER_ADDRESS      "192.168.1.67"
#define BROKER_PORT  1883
#define DEVICE_NAME "td"

class MQTT_Client {
public:
    MQTT_Client() :
            client(),
            mqtt(&client, BROKER_ADDRESS, BROKER_PORT),
            discover_pm03(&mqtt, "homeassistant/sensor/pm03/config"),
            discover_pm1(&mqtt, "homeassistant/sensor/pm1/config"),
            discover_pm25(&mqtt, "homeassistant/sensor/pm25/config"),
            discover_pm50(&mqtt, "homeassistant/sensor/pm50/config"),
            discover_pm100(&mqtt, "homeassistant/sensor/pm100/config"),
            discover_temperature(&mqtt, "homeassistant/sensor/temperature/config"),
            discover_humidity(&mqtt, "homeassistant/sensor/humidity/config"),
            discover_pressure(&mqtt, "homeassistant/sensor/pressure/config"),
            discover_gas_resistance(&mqtt, "homeassistant/sensor/gas_resistance/config"),
            publish_state(&mqtt, DEVICE_NAME "/state") {};

    void config();
    void state(const ParticleReadings *particleReadings, const GasReadings *gasReadings);

protected:
    void config_publish(Adafruit_MQTT_Publish &discover, const char buffer[]);
    WiFiClient client;
    Adafruit_MQTT_Client mqtt;
    Adafruit_MQTT_Publish discover_pm03;
    Adafruit_MQTT_Publish discover_pm1;
    Adafruit_MQTT_Publish discover_pm25;
    Adafruit_MQTT_Publish discover_pm50;
    Adafruit_MQTT_Publish discover_pm100;
    Adafruit_MQTT_Publish discover_temperature;
    Adafruit_MQTT_Publish discover_humidity;
    Adafruit_MQTT_Publish discover_pressure;
    Adafruit_MQTT_Publish discover_gas_resistance;
    Adafruit_MQTT_Publish publish_state;

    void _connect();
};

#endif //AIR_QUALITY_MONITOR_CLIENT_H
