#!/bin/bash

ROS_DIR=$HOME/bin/ros2-osx
INSTALL_DIR=$HOME/bin/gazebo_ros_pkgs
DEPS_INSTALL_DIR=$INSTALL_DIR/deps
QWT_TARBALL=./qwt-6.1.5.tar.bz2

check_pyenv() {
    if ! command -v pyenv &> /dev/null
    then
        echo "Install pyenv first"
        exit 1
    fi
}

activate_ros() {
    source $ROS_DIR/setup.bash
}

install_boost_python() {
    brew install boost-python3
}

install_qwt() {
    QWT_INSTALL_PATH=$INSTALL_DIR/qwt
    mkdir -p $QWT_INSTALL_PATH
    tar -xf $QWT_TARBALL -C $QWT_INSTALL_PATH
}

install_pkg_tools() {
    pip install -U colcon-common-extensions
    pip install -U rosdep
    sudo rosdep init
    rosdep update
}

install_gazebo_ros_pkgs() {
    mkdir -p $DEPS_INSTALL_DIR
    cd $DEPS_INSTALL_DIR
    read -r -d '' deps << EOL
https://github.com/ros-simulation/gazebo_ros_pkgs.git
https://github.com/ros-perception/image_common.git
https://github.com/ros-perception/vision_opencv.git
EOL
    for dep in $deps
    do
        echo "Installing $dep..."
        git clone --branch ros2 $dep
    done
    rosdep install --from-paths . --ignore-src -r -y
    colcon build --symlink-install
}

install() {
    PREVIOUS="$PWD"
    check_pyenv
    # mkdir -p $INSTALL_DIR
    cd $INSTALL_DIR
    activate_ros
    # install_pkg_tools
    # install_boost_python
    install_gazebo_ros_pkgs
    cd $PREVIOUS
}

install
