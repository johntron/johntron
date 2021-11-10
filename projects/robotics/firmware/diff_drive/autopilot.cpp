#include <cstdio>
#include "./diff_drive.cpp"

class Autopilot {
    DiffDrive::DiffDrive diffDrive;
public:
    Autopilot(DiffDrive::DiffDrive diffDrive) : diffDrive(diffDrive) {}
    void go() {
        DiffDrive::accel accel;
        accel.linear = 1.0;
        accel.angular = 0.1;
        diffDrive.accel(accel);
        DiffDrive::accel newAccel = diffDrive.accel();
        printf("%0.1f, %0.1f", newAccel.linear, newAccel.angular);
    }
};
