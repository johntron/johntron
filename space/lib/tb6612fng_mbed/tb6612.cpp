/******************************************************************************
TB6612FNG H-Bridge Motor Driver for mbed
Based on Michelle @ SparkFun Electronics' library for Arduino (thanks!)
8/20/16
https://github.com/sparkfun/SparkFun_TB6612FNG_Arduino_Library
******************************************************************************/



#include "tb6612.h"
#include "mbed.h"

Motor::Motor(PinName In1pin, PinName In2pin, PinName PWMpin, PinName STBYpin): In1(In1pin), In2(In2pin), PWM(PWMpin), Standby(STBYpin) {}

void Motor::drive(float speed)
{
  Standby = 1;
  if (speed>=0) fwd(speed);
  else rev(-speed);
}
void Motor::drive(float speed, int duration_ms)
{
  drive(speed);
  wait_ms(duration_ms);
}

void Motor::stop()
{
	Standby = 1;
	In1 = 1;
	In2 = 1;
	PWM = 1.0;
}

void Motor::fwd(float speed)
{
   Standby = 1;
   In1 = 1;
   In2 = 0;
   PWM = speed;
}

void Motor::rev(float speed)
{
   In1 = 0;
   In2 = 1;
   PWM = speed;
}

void Motor::brake()
{
   In1 = 1;
   In2 = 1;
   PWM = 0;
}

void Motor::standby()
{
   Standby = 0;
}

void forward(Motor motor1, Motor motor2, float speed)
{
	motor1.drive(speed);
	motor2.drive(speed);
}
void forward(Motor motor1, Motor motor2)
{
	motor1.drive(DEFAULTSPEED);
	motor2.drive(DEFAULTSPEED);
}


void back(Motor motor1, Motor motor2, float speed)
{
	float temp = abs(speed);
	motor1.drive(-temp);
	motor2.drive(-temp);
}
void back(Motor motor1, Motor motor2)
{
	motor1.drive(-DEFAULTSPEED);
	motor2.drive(-DEFAULTSPEED);
}
void left(Motor left, Motor right, float speed)
{
	float temp = abs(speed)/2;
	left.drive(-temp);
	right.drive(temp);
	
}


void right(Motor left, Motor right, float speed)
{
    float temp = abs(speed)/2;
	left.drive(temp);
	right.drive(-temp);
	
}
void brake(Motor motor1, Motor motor2)
{
	motor1.brake();
	motor2.brake();
}
