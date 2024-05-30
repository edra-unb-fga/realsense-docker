# docker build -t t265_image

FROM ros:foxy

RUN apt update && apt install -y \
    ros-foxy-realsense2-camera \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/foxy/setup.bash" >> /root/.bashrc

CMD ["/bin/bash"]

