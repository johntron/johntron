/******************************************************************************
TB6612FNG H-Bridge Motor Driver for mbed
Based on Michelle @ SparkFun Electronics' library for Arduino (thanks!)
8/20/16
https://github.com/sparkfun/SparkFun_TB6612FNG_Arduino_Library
******************************************************************************/

#include "differential_drive.h"

namespace tb6612 {

DifferentialDrive::DifferentialDrive(Motor leftMotor, Motor rightMotor)
    : leftMotor(leftMotor), rightMotor(rightMotor) {}

void DifferentialDrive::forward(float speed) {
  leftMotor.drive(speed);
  rightMotor.drive(speed);
}

void DifferentialDrive::back(float speed) {
  float temp = abs(speed);
  leftMotor.drive(-temp);
  rightMotor.drive(-temp);
}

void DifferentialDrive::left(float speed) {
  float temp = abs(speed);
  leftMotor.drive(-temp);
  rightMotor.drive(temp);
}

void DifferentialDrive::right(float speed) {
  float temp = abs(speed);
  leftMotor.drive(temp);
  rightMotor.drive(-temp);
}

void DifferentialDrive::brake() {
  leftMotor.brake();
  rightMotor.brake();
}

void DifferentialDrive::stop() {
  leftMotor.stop();
  rightMotor.stop();
}

}