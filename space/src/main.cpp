#include "tb6612.h"
#include "mbed.h"

int main() {
  using namespace tb6612;
  DigitalOut led(LED1);
  Motor left(PB_4, PB_5, PB_3, PB_10);
  Motor right(PA_8, PA_9, PC_7, PB_10);
  DifferentialDrive drive(left, right);

  float speed = 1.0f;

  while (1) {
    drive.forward(speed);
    wait(1);
    drive.stop();
    wait(1);
    drive.back(speed);
    wait(1);
    drive.stop();
    wait(1);
    drive.left(speed);
    wait(1);
    drive.stop();
    wait(1);
    drive.right(speed);
    wait(1);
    drive.stop();
    wait(1);
  }
}

/**
 * TODO:
 * * Rename drive.back to drive.reverse? - make consistent with Motor
 * * Flyback voltage/current?
 * * When do I integrate with simulation?
 * * Other motor
 * * Separate PSU for motors?
 * * Overtemp protection?
 * * Overcurrent protection?
 * * Order additional MCU's?
 * * Higher-level library for things like accel/decel, input-to-velocity map, smoothing, etc.?
 */
