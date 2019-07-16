#include "tb6612.h"
#include "mbed.h"
#include "./command.h"

#if !DEVICE_I2CSLAVE
#error [NOT_SUPPORTED] I2C Slave is not supported
#endif

#define I2C_FREQUENCY 10000
#define SLAVE_ADDRESS 0b10000
#define FRAME_SIZE_BYTES 512

const char *bit_rep[16] = {
    [ 0] = "0000", [ 1] = "0001", [ 2] = "0010", [ 3] = "0011",
    [ 4] = "0100", [ 5] = "0101", [ 6] = "0110", [ 7] = "0111",
    [ 8] = "1000", [ 9] = "1001", [10] = "1010", [11] = "1011",
    [12] = "1100", [13] = "1101", [14] = "1110", [15] = "1111",
};

void print_byte(char byte)
{
  printf("0b%s%s ", bit_rep[byte >> 4], bit_rep[byte & 0x0F]);
}

void print_frame(char* frame) {
  for (int i = 0; i < FRAME_SIZE_BYTES; i += 1) {
    print_byte(*(frame + i));
  }
}

void print_command (struct set_velocity command) {
  printf("set_velocity: %f, %f\n", command.speed, command.turn_ratio);
  printf("\n");
}

struct set_velocity frame_to_command(char* frame) {
  struct set_velocity command;
  command.speed = 0.0;
  command.turn_ratio = 0.0;
  sscanf(frame, "%f,%f", &command.speed, &command.turn_ratio);
  return command;
}

I2CSlave slave(I2C_SDA, I2C_SCL);
using namespace tb6612;
Motor left(PB_4, PB_5, PB_3, PB_10);
Motor right(PA_8, PA_9, PC_7, PB_10);
DifferentialDrive drive(left, right);

int main() {
  char* frame = (char*) malloc(FRAME_SIZE_BYTES);
  struct set_velocity command;

  slave.frequency(I2C_FREQUENCY);
  slave.address(SLAVE_ADDRESS);

  printf("Control booted\n");

  while (1) {
    int i = slave.receive();
    switch (i) {
      case I2CSlave::ReadAddressed:
        printf("Ignoring read (addressed)");
        break;
      case I2CSlave::WriteGeneral:
        slave.read(frame, FRAME_SIZE_BYTES);
        printf("Read (general):\n");
        command = frame_to_command(frame);
        print_command(command);
        break;
      case I2CSlave::WriteAddressed:
        slave.read(frame, FRAME_SIZE_BYTES);
        printf("Read (addressed):\n");
        command = frame_to_command(frame);
        print_command(command);
        drive.speedAndRotation(command.speed, command.turn_ratio);
        wait(1);
        drive.speedAndRotation(0.0, 0.0);
        break;
      case I2CSlave::NoData:
        // No data - ignore
        break;
      default:
        printf("Unknown message: %d\n", i);
        break;
    }
  }
}
