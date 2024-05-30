#!/bin/bash
export ROS_DOMAIN_ID=1
export ROS_LOCALHOST_ONLY=0

IMAGE_NAME=t265_container

# Allow local connections to the X server for GUI applications in Docker
xhost +local:docker

# Setup for X11 forwarding to enable GUI
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Run the Docker container with the selected image and configurations for GUI applications
docker run -it --rm \
    --name t265_container \
    --privileged \
    --network=host \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --volume /dev/:/dev/ \
    --env="ROS_LOCALHOST_ONLY=0" \
    --env="ROS_DOMAIN_ID=1" \
    $IMAGE_NAME \
    ros2 launch realsense2_camera rs_launch.py enable_pose:=true camera_name:=t265 device_type:=t265 fisheye_width:=848 fisheye_height:=800 unite_imu_method:=linear_interpolation

