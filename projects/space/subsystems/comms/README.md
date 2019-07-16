# Spacecraft comms

Build with a Sparkfun ESP32 Thing


## Tools

Built with [Mongoose].

## Troubleshooting

The [defaults for the crystal oscillator (XTAL) changed for esp-idf](https://esp32.com/viewtopic.php?t=2800), and the Sparkfun ESP32 Thing won't work with a vanilla installation. Modify src/sdkconfig.h to fix.

## Todo

* Messages (e.g. heading_change, accel vector, duration/timeout)
* Hardware abstraction layer for control subsystem
* Should subsystems define their own API's, or should comms host these definitions?

[Mongoose]: https://github.com/cesanta/mongoose
