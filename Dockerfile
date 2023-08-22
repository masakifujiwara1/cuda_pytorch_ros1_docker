FROM anibali/pytorch:1.11.0-cuda11.5-ubuntu20.04

SHELL ["/bin/bash", "-c"]

WORKDIR /home/user
ENV HOME /home/user

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# SHELL ["/bin/bash", "-c"]

# install apt apps
RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo -s && sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && sudo apt-get -y install tzdata
RUN sudo apt-get update && sudo apt-get install -y vim git lsb-release gnupg tmux curl
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration

# install pip3
RUN sudo apt-get install -y python3-pip

# ros noetic setup
RUN git clone https://github.com/ryuichiueda/ros_setup_scripts_Ubuntu20.04_desktop.git
# RUN ./ros_setup_scripts_Ubuntu20.04_desktop/step0.bash 
RUN ./ros_setup_scripts_Ubuntu20.04_desktop/step1.bash

RUN sudo apt-get install -y ros-noetic-rqt-* 
RUN sudo apt-get install -y python3-catkin-tools

ENV USER user

# set catkin workspace
COPY config/git_clone.sh /home/user/git_clone.sh
RUN . /opt/ros/noetic/setup.sh
# RUN rm -rf /root/src /root/catkin_ws
RUN sudo --user $USER mkdir -p catkin_ws/src && cd ~/catkin_ws 
RUN cd ~/catkin_ws/src && . /home/user/git_clone.sh

COPY config/.bashrc $HOME/.bashrc
COPY config/.vimrc $HOME/.vimrc

# clean workspace
RUN sudo rm -rf git_clone.sh ros_setup_scripts_Ubuntu20.04_desktop :


