## Running

1. Enable camera with raspi-config
2. Test video - see below
3. [Install tensorflow lite](https://www.tensorflow.org/lite/guide/python#install_tensorflow_lite_for_python)
4. sudo apt install libopenjp2-7 libopenexr-dev libavcodec-dev libavformat-dev libswscale-dev 

## Testing video

On the pi:
```
libcamera-vid --listen -o tcp://0.0.0.0:8888 -t 0 --width 1920 --height 1080
```

In VLC, connect to network stream with:
```
tcp/h.264://192.168.1.241:8888
```

## Todo

3. Review low-level motor driver code, and design API the diff drive will use
4. Create mock for motor driver that just logs output - integrate with diff drive
5. Create / compile mbed project that includes: autopilot, diff drive, motor controller mock
6. Decide how diff drive will be controlled in gazebo - autopilot? ros2 service with messages dispatched from cli?
7. Compile gazebo plugin for diff drive and run simulation
8. --- checkpoint --- What to refactor, cleanup, improve DX? CMake?
9. Create abstraction layer between firmware and mbed?

Sometime in the future:

1. Look into ROS / YARP messaging
2. Possible to use ROS from computer to microcontroller?
3. Camera tradeoffs / MVP
   1. What's possible with most basic camera (e.g. Pi camera)?
4. Hardware requirements for OpenVSLAM?
5. Choose embedded board
6. Simulation environment for training / dev purposes? KITTI?

## Reference

https://github.com/balena-os/wifi-connect
https://buildroot.org/
https://www.balena.io/
https://barebox.org/
https://docs.docker.com/engine/ and https://docs.docker.com/engine/api/
https://hieromon.github.io/AutoConnect/index.html
https://explainingcomputers.com/sbc.html and https://hackerboards.com/
https://ros-mobile-robots.com/theory/motion-and-odometry/
https://link.springer.com/content/pdf/10.1007%2F978-3-319-62533-1.pdf
https://www.electronicdesign.com/altembedded/article/21143598/c20-serves-up-intriguing-embedded-features
https://en.wikipedia.org/wiki/Lambda_lifting
http://planning.cs.uiuc.edu/node659.html - differential drive algorithm
https://alandefreitas.github.io/moderncpp/
https://docs.ros.org/en/galactic/Tutorials/Writing-A-Simple-Cpp-Service-And-Client.html
http://wiki.ros.org/roscpp/Overview/Publishers%20and%20Subscribers#Subscribing_to_a_Topic
https://www.sparkfun.com/products/14451
https://docs.microsoft.com/en-us/cpp/cpp/modules-cpp?view=msvc-160
http://gazebosim.org/tutorials?cat=guided_i&tut=guided_i5 - gazebo plugins
https://github.com/micro-ROS/micro_ros_zephyr_module
https://learnopencv.com/embedded-computer-vision-which-device-should-you-choose/
https://en.wikipedia.org/wiki/Kalman_filter
https://opencv.org/
https://openai.com/
https://github.com/osrf/gazebo/tree/gazebo6/examples/plugins
https://www.ssel.arizona.edu/research-projects/space-guidance
https://github.com/nasa/cFS
https://cfs.gsfc.nasa.gov/cFS-OviewBGSlideDeck-ExportControl-Final.pdf
https://github.com/Unity-Technologies/Unity-Robotics-Hub
https://globaljournals.org/GJRE_Volume14/1-Kinematics-Localization-and-Control.pdf
file:///Users/johntron/Downloads/EI2020.pdf