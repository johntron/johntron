## Todo

3. Review low-level motor driver code, and design API the diff drive will use
4. Create mock for motor driver that just logs output - integrate with diff drive
5. Create / compile mbed project that includes: autopilot, diff drive, motor controller mock
6. Decide how diff drive will be controlled in gazebo - autopilot? ros2 service with messages dispatched from cli?
7. Compile gazebo plugin for diff drive and run simulation
8. --- checkpoint --- What to refactor, cleanup, improve DX? CMake?

Sometime in the future:

1. Look into ROS / YARP messaging
2. Possible to use ROS from computer to microcontroller?
3. Camera tradeoffs / MVP
   1. What's possible with most basic camera (e.g. Pi camera)?
4. Hardware requirements for OpenVSLAM?
5. Choose embedded board
6. Simulation environment for training / dev purposes? KITTI?