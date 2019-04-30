/******************************************************************************
TB6612FNG H-Bridge Motor Driver for mbed
Based on Michelle @ SparkFun Electronics' library for Arduino (thanks!)
8/20/16
https://github.com/sparkfun/SparkFun_TB6612FNG_Arduino_Library
******************************************************************************/


#ifndef tb6612_mbed_h
#define tb6612_mbed_h

#include "mbed.h"

//used in some functions so you don't have to send a speed
#define DEFAULTSPEED 255  


class Motor
{
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
	
  private:
    //variables for the 2 inputs, PWM input, Offset value, and the Standby pin
	DigitalOut In1, In2;
	PwmOut PWM; 
	DigitalOut Standby;
	
	//private functions that spin the motor CC and CCW
	void fwd(float speed);
	void rev(float speed);


};

//Takes 2 motors and goes forward, if it does not go forward adjust offset 
//values until it does.  These will also take a negative number and go backwards
//There is also an optional speed input, if speed is not used, the function will
//use the DEFAULTSPEED constant.
void forward(Motor motor1, Motor motor2, float speed);
void forward(Motor motor1, Motor motor2);

//Similar to forward, will take 2 motors and go backwards.  This will take either
//a positive or negative number and will go backwards either way.  Once again the
//speed input is optional and will use DEFAULTSPEED if it is not defined.
void back(Motor motor1, Motor motor2, float speed);
void back(Motor motor1, Motor motor2);

//Left and right take 2 motors, and it is important the order they are sent.
//The left motor should be on the left side of the bot.  These functions
//also take a speed value
void left(Motor left, Motor right, float speed);
void right(Motor left, Motor right, float speed);

//This function takes 2 motors and and brakes them
void brake(Motor motor1, Motor motor2);










#endif
