/******************************************************************************
TB6612FNG H-Bridge Motor Driver for mbed
Based on Michelle @ SparkFun Electronics' library for Arduino (thanks!)
8/20/16
https://github.com/sparkfun/SparkFun_TB6612FNG_Arduino_Library
******************************************************************************/

#include "mbed.h"

const float HIGH = 1.0;
const float LOW = 0.0;

class MotorDriver {
    DigitalOut In1, In2;
    PwmOut PWM;
    DigitalOut Standby;
public:
    MotorDriver(PinName In1pin, PinName In2pin, PinName PWMpin, PinName STBYpin)
            : In1(In1pin), In2(In2pin), PWM(PWMpin), Standby(STBYpin) {}

    void stop() {
        Standby = HIGH;
        In1 = LOW;
        In2 = LOW;
        PWM = 1.0;
    }

    void standby() {
        Standby = LOW;
    }

    void fwd(float speed) {
        Standby = HIGH;
        In1 = HIGH;
        In2 = LOW;
        PWM = speed;
    }

    void rev(float speed) {
        Standby = HIGH;
        In1 = LOW;
        In2 = HIGH;
        PWM = speed;
    }
};