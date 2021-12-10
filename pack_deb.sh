#!/bin/bash

if [ -f TEMPLATE_PROCESS.deb ]; then
   mv TEMPLATE_PROCESS.deb /tmp/
   echo "previous debian moved to /tmp/"
fi

dpkg-deb --build TEMPLATE_PROCESS
