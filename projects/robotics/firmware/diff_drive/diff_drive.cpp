#include "./parameters.cpp"
#include "./motor_driver.cpp"

namespace DiffDrive {
    class DiffDrive {
        velocity _velocity;
        accel _accel;
        MotorDriver leftMotor = MotorDriver(PA_8, PA_9, PC_7, PB_10);
        MotorDriver rightMotor = MotorDriver(PB_4, PB_5, PB_3, PB_10);
    public:
        velocity velocity() {
            return this->_velocity;
        }
        accel accel() {
            return this->_accel;
        }
        void velocity(const struct velocity newVelocity) {
            this->_velocity = newVelocity;
            if (newVelocity.angular == 0) {

            }
        }
        void accel(const struct accel newAccel) {
            this->_accel = newAccel;
        }
    };
}