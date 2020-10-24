#!/bin/bash

# get the data_folder
source /opt/robot/config/robot.config

echo "Update Data Directory"
date

if [ "$ENABLE_NEW_DATA_FOLDERS" -eq "0" ]; then
   echo "New folder script deactivated."
   echo "To change, activate ENABLE_NEW_DATA_FOLDERS in /opt/robot/config/robot.config"
   echo "Quitting. ";
   exit;
fi

# if the root folder doesn't exist, make it
[[ -d $DATA_FOLDER_ROOT ]] || mkdir $DATA_FOLDER_ROOT

# get current time for subfolder name
dt=$(date '+%Y-%m-%d-%H-%M-%S');

# make a subdirectory timestamped with the current time
subfolder_path=$DATA_FOLDER_ROOT/$dt

mkdir $subfolder_path
rm -rf $DATA_FOLDER_ROOT/most_recent
ln -s $subfolder_path $DATA_FOLDER_ROOT/most_recent
echo $subfolder_path > /tmp/robot-data-folder-path
echo "Created $subfolder_path"
echo ""

#TODO stupid simple rospy script that...
	#updates rosparam for data folder
	#publishes rosservice announcing folder update
