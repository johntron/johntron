#include "mbed.h"
#include "autopilot.cpp"

// Run with:
// clang++ --std=c++20 main.cpp && ./autopilot.out

int main()
{
    DiffDrive::DiffDrive diffDrive;
    Autopilot autopilot(diffDrive);
    autopilot.go();
}
