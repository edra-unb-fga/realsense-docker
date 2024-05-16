FROM osrf/ros:foxy-desktop


RUN apt update && apt install -y \
    git \
    libssl-dev \
    libusb-1.0-0-dev \
    pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    wget \
    tar

# baixar codigo fonte do repo
RUN wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.50.0.tar.gz \
    && tar -xvzf v2.50.0.tar.gz \
    && cd librealsense-2.50.0

WORKDIR /librealsense-2.50.0

RUN mkdir build \
    && cd build \
    && cmake ../ \
    && make \
    && make install

RUN mkdir -p ~/ros2_ws/src \
    && cd ~/ros2_ws/src/ \
    && git clone --branch ros2-legacy https://github.com/IntelRealSense/realsense-ros.git \
    && cd ~/ros2_ws

RUN apt-get install python3-rosdep -y
RUN rosdep init \
    rosdep update \
    rosdep init \
    rosdep install -i --from-path src --rosdistro foxy --skip-keys=librealsense2 -y

WORKDIR ~/ros2_ws
RUN colcon build


