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

void DifferentialDrive::speedAndRotation(float speed, float rotation) {
  float primarySpeed = speed;
  float skiddingSpeed = speed - (abs(rotation) * 2);

  if (rotation > 0) {
    rightMotor.drive(primarySpeed);
    leftMotor.drive(skiddingSpeed);
  }

  if (rotation < 0) {
    rightMotor.drive(skiddingSpeed);
    leftMotor.drive(primarySpeed);
  }

  if (rotation == 0) {
    rightMotor.drive(primarySpeed);
    leftMotor.drive(primarySpeed);
  }
}

void DifferentialDrive::forward(float speed) {
  speedAndRotation(speed, 0);
}

void DifferentialDrive::back(float speed) {
  speedAndRotation(-speed, 0);
}

void DifferentialDrive::left(float speed) {
  speedAndRotation(speed, -1.0);
}

void DifferentialDrive::right(float speed) {
  speedAndRotation(speed, 1.0);
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