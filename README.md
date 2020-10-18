# robotTools

## What is it?
Robot Tools is a group of utilities packed into an auto-launching ecosystem. It is designed to be a framework that you can add your own programs and scripts to in order to streamline bringing up your robot.

## What does it do?
The default system is an auto-launching screen session that launches three tabs.
  - BASH: empty shell to use
  - ROS: roscore
  - HTOP: htop
Users can add whatever additional processes they want (ex. sensor drivers, image processing, path planning...)    
    
The default system also launches two cron jobs
  - data_folder: creates a new folder for robot data every X minutes
  - delete_data: deletes oldest data in the data folder when disk space exceeds XX%
  
## Installation
To install it on your own system, run the script _build_and_install.sh_
To install it on a robot...
- _pack_deb.sh_
- scp robot-tools.deb install_deb.sh your_robot@<robot_ip_address>:/tmp/
- (On robot) _cd /tmp/_
- (On robot) _./install_deb.sh_
  
## Using the custom screen session
- To attach to the screen: _screen -x robot_
- Once inside the screen, navigate with: Ctrl+(left,right) arrow
- To exit the screen, Ctrl+\ then press 'd'
- Standard gnuscreen commands are the same, but the escape key is remapped to \\

## Configuration
- Explore the opt/robot/config folder
- You can change robot environment variables in _robot.config_
- You can also add/remove/change screen tabs in gnuscreeen-robot
- If you really want, you can modify the screen behavior in gnuscreen-base
