#include "mqtt_client.h"

#define DEBUG(msg) \
    Serial.println(msg)

// See abbreviations here: https://www.home-assistant.io/docs/mqtt/discovery/#discovery-topic
const char configTemplateRaw[] = "{\"name\":\"%s\",\"dev_cla\":\"%s\",\"stat_t\":\"td/state\",\"unit_of_meas\":\"%s\",\"val_tpl\":\"%s\"}";

void configJson(
        char result[],
        const char name[],
        const char deviceClass[],
        const char unit[],
        const char valueTemplate[]
) {
    snprintf(
            result,
            5000,
            configTemplateRaw,
            name,
            deviceClass,
            unit,
            valueTemplate
    );
}

const int configSize = 1000;

void MQTT_Client::config() {
    char buffer[configSize];
    _connect();

    // 0.3um
    configJson(
            buffer,
            "PM over 0.3um",
            "pm1",
            "µg/m³",
            "{{value_json.pm03}}"
    );
    config_publish(discover_pm03, buffer);

    // 1.0um
    configJson(
            buffer,
            "PM over 1.0um",
            "pm1",
            "µg/m³",
            "{{value_json.pm1}}"
    );
    config_publish(discover_pm1, buffer);

    // 2.5um
    configJson(
            buffer,
            "PM over 2.5um",
            "pm25",
            "µg/m³",
            "{{value_json.pm25}}"
    );
    config_publish(discover_pm25, buffer);

    // 5.0um
    configJson(
            buffer,
            "PM over 5.0um",
            "pm25",
            "µg/m³",
            "{{value_json.pm50}}"
    );
    config_publish(discover_pm50, buffer);

    // 10.0um
    configJson(
            buffer,
            "PM over 10.0um",
            "pm25",
            "µg/m³",
            "{{value_json.pm100}}"
    );
    config_publish(discover_pm100, buffer);

    // temperature
    configJson(
            buffer,
            "Temperature",
            "temperature",
            "°C",
            "{{value_json.temperature}}"
    );
    config_publish(discover_temperature, buffer);

    // humidity
    configJson(
            buffer,
            "Humidity",
            "humidity",
            "% RH",
            "{{value_json.humidity}}"
    );
    config_publish(discover_humidity, buffer);

    // pressure
    configJson(
            buffer,
            "Pressure",
            "pressure",
            "kPa",
            "{{value_json.pressure}}"
    );
    config_publish(discover_pressure, buffer);

    // gas resistance
    configJson(
            buffer,
            "Gas resistance",
            "humidity", // TODO better device class
            "kΩ",
            "{{value_json.gas_resistance}}"
    );
    config_publish(discover_gas_resistance, buffer);
}

void MQTT_Client::config_publish(Adafruit_MQTT_Publish &discover, const char buffer[]) {
    DEBUG("Sending config:");
    DEBUG(buffer);
    if (!discover.publish(buffer)) {
        Serial.println("Failed to publish config");
        return;
    }
    Serial.println("Discovery published");
}

void MQTT_Client::state(const ParticleReadings *particles, const GasReadings *gas) {
    char buffer[1000];
    const char tpl[] = "{\"pm03\": \"%u\", \"pm1\": \"%u\", \"pm25\":\"%u\", \"pm50\":\"%u\", \"pm100\": \"%u\", \"temperature\": \"%0.1f\", \"humidity\": \"%0.1f\", \"pressure\": \"%0.2f\", \"gas_resistance\": \"%0.2f\"}";
    snprintf(
            buffer,
            1000,
            tpl,
            particles->particles_03um,
//            particles->particles_05um,
            particles->particles_10um,
            particles->particles_25um,
            particles->particles_50um,
            particles->particles_100um,
            gas->temperature,
            gas->humidity,
            (float)gas->pressure / 1000,
            (float)gas->gas_resistance / 1000
    );
    DEBUG("State:");
    DEBUG(buffer);
    bool result = publish_state.publish(buffer);
    if (!result) {
        Serial.println("Failed to publish state");
    } else {
        Serial.println("State published");
    }
}

void MQTT_Client::_connect() {
    if (mqtt.connected()) {
        return;
    }

    Serial.print("Connecting to MQTT... ");

    int ret;
    while ((ret = mqtt.connect()) != 0) { // connect will return 0 for connected
        Serial.println(mqtt.connectErrorString(ret));
        Serial.println("Retrying MQTT connection in 5 seconds...");
        mqtt.disconnect();
        delay(5000);  // wait 5 seconds
    }
    Serial.println("MQTT Connected!");
}