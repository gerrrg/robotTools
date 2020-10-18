#!/bin/bash
#
############################################################################### 
# Author            :  Louwrentius
# Contact           : louwrentius@gmail.com
# Initial release   : August 2011
# Licence           : Simplified BSD License
############################################################################### 

VERSION=1.01
#
# Mounted volume to be monitored.
#
MOUNT="$1"
#
# Folder on mounted volume to delete files in
#
FOLDER="$2"
#
# Maximum threshold of volume used as an integer that represents a percentage:
# 95 = 95%.
#
MAX_USAGE="$3"
#
# Failsafe mechansim. Delete a maxium of MAX_CYCLES files, raise an error after
# that. Prevents possible runaway script. Disable by choosing a high value.
#
MAX_CYCLES=5

show_header () {
    echo
    echo DELETE OLD FILES $VERSION
    date
}
reset () {
    OLDEST_FILE=""
    OLDEST_DATE=0
    ARCH=`uname`
}
check_capacity () {
    USAGE=`df -h | grep "$MOUNT" | awk '{ print $5 }' | sed s/%//g`
    if [ ! "$?" == "0" ]    
    then
        echo "Error: mountpoint $MOUNT not found in df output."
        exit 1
    fi

    if [ -z "$USAGE" ]
    then
        echo "Didn't get usage information of $MOUNT"
        echo "Mountpoint does not exist or please remove trailing slash."
        exit 1
    fi

    if [ "$USAGE" -gt "$MAX_USAGE" ]
    then
        echo "Usage of $USAGE% exceeded limit of $MAX_USAGE percent."
        return 0
    else
        echo "Usage of $USAGE% is within limit of $MAX_USAGE percent."
        return 1
    fi
}
check_age () {
    FILE="$1"
    if [ "$ARCH" == "Linux" ]
    then
        FILE_DATE=`stat -c %Z "$FILE"`
    elif [ "$ARCH" == "Darwin" ]
    then
        FILE_DATE=`stat -f %Sm -t %s "$FILE"`
    else
        echo "Error: unsupported architecture."
        echo "Send a patch for the correct stat arguments for your architecture."
    fi
        
    NOW=`date +%s`
    AGE=$((NOW-FILE_DATE))
    if [ "$AGE" -gt "$OLDEST_DATE" ]
    then
        export OLDEST_DATE="$AGE"
        export OLDEST_FILE="$FILE"
    fi
}
process_file () {
    FILE="$1"
    #
    # Replace the following commands with wathever you want to do with 
    # this file. You can delete files but also move files or do something else.
    #
    echo "Deleting oldest file $FILE"
    rm -rf "$FILE"
}

show_header
source /opt/robot/config/robot.config
if [ "$ENABLE_DATA_DELETION" -eq "0" ]; then
   echo "Data deletion deactivated."
   echo "To change, activate ENABLE_DATA_DELETION in /opt/robot/config/robot.config"
   echo "Quitting. ";
   exit;
fi

reset

while check_capacity
do
    if [[ "$CYCLES" -gt "$MAX_CYCLES" ]]
    then
        echo "Error: after $MAX_CYCLES deleted files still not enough free space."
        exit 1
    fi
    
    reset

    if [[ $( ls -l -1 $FOLDER | wc -l ) -lt 2 ]]; then
        echo "This folder is empty. Excessive disk usage in another directory."
        exit 1
    fi

    FILES=`find "$FOLDER"/* `
    echo $FILES
    
    IFS=$'\n'
    for x in $FILES
    do
        check_age "$x"
    done

    echo $OLDEST_FILE
    if [ -e "$OLDEST_FILE" ]
    then
        echo Deleting $OLDEST_FILE
        process_file "$OLDEST_FILE"
    else
        echo "Error: somehow, item $OLDEST_FILE disappeared."
    fi
    ((CYCLES++))
    echo ""
done
echo
