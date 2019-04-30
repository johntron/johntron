#include "tb6612.cpp"
#include "mbed.h"

DigitalOut led(LED1);
Motor motor(PB_4, PB_5, PB_3, PB_10);

int main() {
	motor.drive(0.5f);
	wait(1);
	motor.drive(-0.5f);
	wait(1);
	motor.stop();
	wait(1);
	/*
	DigitalOut in1(PB_4);
	DigitalOut in2(PB_5);
	PwmOut pwm(PB_3);
	DigitalOut standby(PB_10);
	in1 = 1;
	in2 = 1;
	pwm = 0.5f;
	standby = 1;
	while(1) {
		motor.drive(1.0f);
		led = 0;
		wait(1);
		motor.drive(0.0f);
		led = 1;
		wait(1);
	}
	*/
}

/**
 * TODO:
 * * Flyback voltage/current?
 * * When do I integrate with simulation?
 * * Other motor
 * * Separate PSU for motors?
 * * Overtemp protection?
 * * Overcurrent protection?
 * * Order additional MCU's?
 * * Higher-level library for things like accel/decel, input-to-velocity map, smoothing, etc.?
 */
