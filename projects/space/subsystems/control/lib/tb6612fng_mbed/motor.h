/******************************************************************************
TB6612FNG H-Bridge Motor Driver for mbed
Based on Michelle @ SparkFun Electronics' library for Arduino (thanks!)
8/20/16
https://github.com/sparkfun/SparkFun_TB6612FNG_Arduino_Library
******************************************************************************/

#ifndef tb6612fng_mbed_motor
#define tb6612fng_mbed_motor

// How to ensure mbed has been loaded?
#include "mbed.h"

namespace tb6612 {

class Motor {
 public:
  // Constructor. Mainly sets up pins.
  Motor(PinName In1pin, PinName In2pin, PinName PWMpin, PinName STBYpin);

  // Drive in direction given by sign, at speed given by magnitude of the
  //parameter.
  void drive(float speed);

  // drive(), but with a wait_ms(duration_ms)
  void drive(float speed, int duration_ms);

  //currently not implemented
  void stop();           // Stop motors, but allow them to coast to a halt.
  //void coast();          // Stop motors, but allow them to coast to a halt.

  //Stops motor by setting both input pins high
  void brake();

  //set the chip to standby mode.  The drive function takes it out of standby
  //(forward, back, left, and right all call drive)
  void standby();

  float speed();

 protected:
  //variables for the 2 inputs, PWM input, Offset value, and the Standby pin
  DigitalOut In1, In2;
  PwmOut PWM;
  DigitalOut Standby;

  //private functions that spin the motor CC and CCW
  void fwd(float speed);
  void rev(float speed);
};

}

#endif

