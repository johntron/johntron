#include "tb6612.h"
#include "mbed.h"

#if !DEVICE_I2CSLAVE
#error [NOT_SUPPORTED] I2C Slave is not supported
#endif

#define I2C_FREQUENCY 100000
#define SLAVE_ADDRESS 0b10000
#define FRAME_SIZE_BYTES 4

const char *bit_rep[16] = {
    [ 0] = "0000", [ 1] = "0001", [ 2] = "0010", [ 3] = "0011",
    [ 4] = "0100", [ 5] = "0101", [ 6] = "0110", [ 7] = "0111",
    [ 8] = "1000", [ 9] = "1001", [10] = "1010", [11] = "1011",
    [12] = "1100", [13] = "1101", [14] = "1110", [15] = "1111",
};

void print_byte(char byte)
{
  printf("%s %s  ", bit_rep[byte >> 4], bit_rep[byte & 0x0F]);
}

I2CSlave slave(I2C_SDA, I2C_SCL);

int main() {
  using namespace tb6612;
  slave.frequency(I2C_FREQUENCY);
  slave.address(SLAVE_ADDRESS);

  char* data = (char*) malloc(FRAME_SIZE_BYTES);
  while (1) {
    int i = slave.receive();
    switch (i) {
      case I2CSlave::ReadAddressed:
        slave.write(data, FRAME_SIZE_BYTES + 1); // Includes null char
        break;
      case I2CSlave::WriteGeneral:
        slave.read(data, FRAME_SIZE_BYTES);
        printf("Read (general):\n");
        print_byte(data[0]);
        print_byte(data[1]);
        print_byte(data[2]);
        print_byte(data[3]);
        printf("\n");
        break;
      case I2CSlave::WriteAddressed:
        slave.read(data, FRAME_SIZE_BYTES);
        printf("Read (addressed):\n");
        print_byte(data[0]);
        print_byte(data[1]);
        print_byte(data[2]);
        print_byte(data[3]);
        printf("\n");
        break;
      case I2CSlave::NoData:
//        printf("No data\n");
        break;
      default:
        printf("Unknown message: %d\n", i);
        break;
    }
    for(int i = 0; i < FRAME_SIZE_BYTES; i++) data[i] = 0;    // Clear buffer
  }

//  Motor left(PB_4, PB_5, PB_3, PB_10);
//  Motor right(PA_8, PA_9, PC_7, PB_10);
//  DifferentialDrive drive(left, right);
//
//  float speed = 1.0f;
//
//  wait(1); // Let things settle

//  while (1) {
//    drive.speedAndRotation(speed, 0.0);
//    wait(1);
//    drive.stop();
//    drive.speedAndRotation(-speed, 0.0);
//    wait(1);
//    drive.stop();
//    drive.speedAndRotation(speed, -1.0);
//    wait(1);
//    drive.stop();
//    drive.speedAndRotation(speed, 1.0);
//    wait(1);
//    drive.stop();
//    drive.speedAndRotation(speed, 0.5);
//    wait(1);
//    drive.stop();
//    drive.speedAndRotation(speed, -0.5);
//    wait(1);
//    drive.stop();
//  }
}
