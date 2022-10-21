#include "particle_sensor.h"

void ParticleSensor::connect() {
    if (!sensor.begin_I2C()) {
        Serial.println("No sensor found!");
        return;
    }
    Serial.println("Connected to PM2.5 sensor");
}

void ParticleSensor::read(ParticleReadings* readings) {
    PM25_AQI_Data data;
    if (!sensor.read(&data)) {
        Serial.println("Could not read from AQI");
        delay(500);  // try again in a bit!
        return;
    }

    Serial.println("AQI reading success");

    Serial.println();
    Serial.println(F("---------------------------------------"));
    Serial.println(F("Concentration Units (standard)"));
    Serial.println(F("---------------------------------------"));
    Serial.print(F("PM 1.0: "));
    Serial.print(data.pm10_standard);
    Serial.print(F("\t\tPM 2.5: "));
    Serial.print(data.pm25_standard);
    Serial.print(F("\t\tPM 10: "));
    Serial.println(data.pm100_standard);
    Serial.println(F("Concentration Units (environmental)"));
    Serial.println(F("---------------------------------------"));
    Serial.print(F("PM 1.0: "));
    Serial.print(data.pm10_env);
    Serial.print(F("\t\tPM 2.5: "));
    Serial.print(data.pm25_env);
    Serial.print(F("\t\tPM 10: "));
    Serial.println(data.pm100_env);
    Serial.println(F("---------------------------------------"));
    Serial.print(F("Particles > 0.3um / 0.1L air:"));
    Serial.println(data.particles_03um);
    Serial.print(F("Particles > 0.5um / 0.1L air:"));
    Serial.println(data.particles_05um);
    Serial.print(F("Particles > 1.0um / 0.1L air:"));
    Serial.println(data.particles_10um);
    Serial.print(F("Particles > 2.5um / 0.1L air:"));
    Serial.println(data.particles_25um);
    Serial.print(F("Particles > 5.0um / 0.1L air:"));
    Serial.println(data.particles_50um);
    Serial.print(F("Particles > 10 um / 0.1L air:"));
    Serial.println(data.particles_100um);
    Serial.println(F("---------------------------------------"));

    readings->pm10_standard = data.pm10_standard;
    readings->pm25_standard = data.pm25_standard;
    readings->pm100_standard = data.pm100_standard;
    readings->pm10_env = data.pm10_env;
    readings->pm25_env = data.pm25_env;
    readings->pm100_env = data.pm100_env;
    readings->particles_03um = data.particles_03um;
    readings->particles_05um = data.particles_05um;
    readings->particles_10um = data.particles_10um;
    readings->particles_25um = data.particles_25um;
    readings->particles_50um = data.particles_50um;
    readings->particles_100um = data.particles_100um;
}
