FROM osrf/ros:noetic-desktop-full

SHELL ["/bin/bash", "-c"]

WORKDIR /home/user
ENV HOME /home/user

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# SHELL ["/bin/bash", "-c"]

# install apt
RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo -s && sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && sudo apt-get -y install tzdata
RUN sudo apt-get update && sudo apt-get install -y vim git lsb-release gnupg tmux curl
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration

# install pip3
RUN sudo apt-get install -y python3-pip

RUN sudo apt-get install -y ros-noetic-rqt-* 
RUN sudo apt-get install -y python3-catkin-tools

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


