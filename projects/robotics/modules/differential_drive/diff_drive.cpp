#include <cmath>
#include "./parameters.cpp"
#include "./motor_driver.cpp"

namespace DiffDrive {
    class DiffDrive {
        float wheelRadius = 1.0;
        float distanceBetweenWheels = 1.0;
        velocity _velocity;
        MotorDriver leftMotor = MotorDriver(PA_8, PA_9, PC_7, PB_10);
        MotorDriver rightMotor = MotorDriver(PB_4, PB_5, PB_3, PB_10);
    public:
        void velocity(const struct velocity newVelocity) {
            this->_velocity = newVelocity;
        }
    };
}