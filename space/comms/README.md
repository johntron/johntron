# Spacecraft comms

Build with a Sparkfun ESP32 Thing

## Troubleshooting

The [defaults for the crystal oscillator (XTAL) changed for esp-idf](https://esp32.com/viewtopic.php?t=2800), and the Sparkfun ESP32 Thing won't work with a vanilla installation. Modify src/sdkconfig.h to fix.