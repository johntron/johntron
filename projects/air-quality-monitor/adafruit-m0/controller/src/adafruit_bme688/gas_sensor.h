#ifndef AIR_QUALITY_MONITOR_GAS_SENSOR_H
#define AIR_QUALITY_MONITOR_GAS_SENSOR_H

#include "Adafruit_BME680.h"
#include "readings.h"

class GasSensor {
public:
    GasSensor();
    bool connect();
    bool read(GasReadings *readings);
private:
    Adafruit_BME680 driver;
};


#endif //AIR_QUALITY_MONITOR_GAS_SENSOR_H
