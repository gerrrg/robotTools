#!/bin/bash

echo "This script is intended to be a convenience only. This key is correct at time of writing but could possibly change."
echo "Please verify the key here:"
echo "http://wiki.ros.org/melodic/Installation/Ubuntu"
echo -e "\nIf you want to verify, please enter Ctrl+C now."
echo "Script will pause for 10 second before installing..."
sleep 10

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt install ros-melodic-ros-base
