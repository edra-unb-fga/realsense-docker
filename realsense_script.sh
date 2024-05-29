#!/bin/bash
set -e

# Fonte os scripts de configuração do ROS
source /opt/ros/foxy/setup.bash
source /root/ros2_ws/install/local_setup.bash

# Iniciar o comando ROS
ros2 launch realsense2_camera rs_t265_launch.py

# Manter o terminal aberto
exec "$@"
