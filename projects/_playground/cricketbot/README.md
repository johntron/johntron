# Intro

ROS 2 and Gazebo are tools to build and design robots. ROS2 is a communications framework to simplify communication between devices. Robots are often designed as a collection of individual subcomponents, and all of these talk together in a way that creates the desired behavior of the robot. ROS2 helps by providing common programmer interfaces for intra-device communication and software to send/receive messages.

Gazebo is a simulation tool that allows a robotics engineer to run simulations using ROS2-compatible robotics systems.

For each device in a robot (e.g. motor controller), robotics engineers incorporate ROS 2 to enable the device to transmit and receive ROS-compatible messages.

# Getting started

Follow ["Installing gazebo_ros_pkgs (ROS 2)"](http://gazebosim.org/tutorials?tut=ros2_installing) to install ROS 2, Gazeo, and the packages to integrate an ROS system into the Gazebo simulator.

On macOS, when you try to run a ros2 program (e.g. `ros2 run ...`), you'll get a bunch of popups complaining about running software from an unverified developer. You can get around this by using `sudo spctl --master-disable` to show the "Allow apps downloaded from: Anywhere" in system preference.

To start running ROS2 programs, you have to setup your shell with the following (assuming you installed gazebo_ros_pkgs to ~/bin/ros2-osx):

```
source ~/bin/ros2-osx/setup.zsh
```

## macOS

I had to manually install gazebo_ros_pkgs - use [install-macos.sh](./install-macos.sh). Tip: use pyenv.
