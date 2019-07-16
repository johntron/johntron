/******************************************************************************
TB6612FNG H-Bridge Motor Driver for mbed
Based on Michelle @ SparkFun Electronics' library for Arduino (thanks!)
8/20/16
https://github.com/sparkfun/SparkFun_TB6612FNG_Arduino_Library
******************************************************************************/

#include "motor.h"
#include "mbed.h"

namespace tb6612 {

class DifferentialDrive {
 public:
  DifferentialDrive(Motor left, Motor right);
  void speedAndRotation(float speed, float rotation);
  void forward(float speed);
  void back(float speed);
  void left(float speed);
  void right(float speed);
  void brake();
  void stop();

 protected:
  Motor leftMotor;
  Motor rightMotor;
};

}
