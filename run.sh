#!/bin/bash

eval "docker container run --network host --gpus all -it --name noetic-pytorch -e DISPLAY=$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v $PWD/docker_share:/home/host_files --privileged --user="$(id -u):$(id -g)" masakifujiwara1/noetic-pytorch:cuda-11.5 bash"
