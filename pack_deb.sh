#!/bin/bash

if [ -f robot-tools.deb ]; then
   mv robot-tools.deb /tmp/
   echo "previous debian moved to /tmp/"
fi

dpkg-deb --build robot-tools