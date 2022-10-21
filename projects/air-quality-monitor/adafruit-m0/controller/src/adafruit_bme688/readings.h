#ifndef AIR_QUALITY_MONITOR_GAS_READINGS_H
#define AIR_QUALITY_MONITOR_GAS_READINGS_H

typedef struct GasReadings {
    float temperature; // Celcius
    float humidity; // RH %
    uint32_t pressure; // Pascals
    uint32_t gas_resistance; // Ohms
};

#endif