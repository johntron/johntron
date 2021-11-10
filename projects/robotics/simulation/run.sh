export GAZEBO_PLUGIN_PATH=$(pwd)/build
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:/usr/local/opt/qt@5
export PATH=$PATH:/usr/local/opt/qt@5/bin

gazebo ./world.world