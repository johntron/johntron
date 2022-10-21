#ifndef AIR_QUALITY_MONITOR_PARTICLE_READINGS_H
#define AIR_QUALITY_MONITOR_PARTICLE_READINGS_H
typedef struct ParticleReadings {
    uint16_t pm10_standard,  ///< Standard PM1.0
    pm25_standard,       ///< Standard PM2.5
    pm100_standard;      ///< Standard PM10.0
    uint16_t pm10_env,       ///< Environmental PM1.0
    pm25_env,            ///< Environmental PM2.5
    pm100_env;           ///< Environmental PM10.0
    uint16_t particles_03um, ///< 0.3um Particle Count
    particles_05um,      ///< 0.5um Particle Count
    particles_10um,      ///< 1.0um Particle Count
    particles_25um,      ///< 2.5um Particle Count
    particles_50um,      ///< 5.0um Particle Count
    particles_100um;     ///< 10.0um Particle Count
};
#endif