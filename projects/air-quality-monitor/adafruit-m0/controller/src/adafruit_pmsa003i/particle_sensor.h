#ifndef AIR_QUALITY_MONITOR_PARTICLE_SENSOR_H
#define AIR_QUALITY_MONITOR_PARTICLE_SENSOR_H

#include <Adafruit_PM25AQI.h>
#include "readings.h"

class ParticleSensor {
public:
    ParticleSensor() : sensor() {}

    void connect();

    void read(ParticleReadings *readings);

private:
    Adafruit_PM25AQI sensor;
};

#endif //AIR_QUALITY_MONITOR_PARTICLE_SENSOR_H
