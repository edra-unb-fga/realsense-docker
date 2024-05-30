#!/bin/bash

# Nome do contêiner Docker em execução
CONTAINER_NAME=ros2_humble_container

# Permitir conexões locais ao servidor X para aplicativos GUI no Docker
xhost +

# Configuração para encaminhamento X11 para habilitar aplicativos GUI
XAUTH=/tmp/.docker.xauth

# Execute o comando no contêiner em execução
docker exec -it \
    --privileged \
    --network=host \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --volume /dev:/dev \
    --device /dev/ttyAMA0:/dev/ttyAMA0 \
    --device /dev/ttyS0:/dev/ttyS0 \
    --env="ROS_LOCALHOST_ONLY=0" \
    --env="ROS_DOMAIN_ID=1" \
    $CONTAINER_NAME /bin/bash
