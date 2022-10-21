#include "gas_sensor.h"

#define DEBUG(msg) \
    Serial.println(msg)

GasSensor::GasSensor(): driver() {};
bool GasSensor::connect() {
    if (!driver.begin()) {
        DEBUG("Failed to connect to sensor");
        return false;
    }
    return true;
}
bool GasSensor::read(GasReadings *readings) {
    if (!driver.performReading()) {
        DEBUG("Could not get reading");
        return false;
    }
    DEBUG("Read gas sensor");

    readings->temperature = driver.temperature;
    readings->humidity = driver.humidity;
    readings->pressure = driver.pressure;
    readings->gas_resistance = driver.gas_resistance;

    Serial.print("Temperature: ");
    Serial.println(readings->temperature);
    Serial.print("Humidity: ");
    Serial.println(readings->humidity);
    Serial.print("Pressure: ");
    Serial.println(readings->pressure);
    Serial.print("Gas resistance: ");
    Serial.println(readings->gas_resistance);

    return true;
}
