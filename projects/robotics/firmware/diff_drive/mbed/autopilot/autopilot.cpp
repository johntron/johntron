#include <cstdio>
#include "../../../modules/differential_drive/diff_drive.cpp"

class Autopilot {
    DiffDrive::DiffDrive diffDrive;
public:
    Autopilot(DiffDrive::DiffDrive diffDrive) : diffDrive(diffDrive) {}
    void go() {
        DiffDrive::velocity velocity;
        velocity.linear = 1.0;
        velocity.angular = 0.1;
        diffDrive.velocity(velocity);
        DiffDrive::velocity newVelocity = diffDrive.velocity();
        printf("%0.1f, %0.1f", newVelocity.linear, newVelocity.angular);
    }
};
