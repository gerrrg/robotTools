#!/bin/bash

a=$(( `screen -ls | grep TEMPLATE_PROCESS | wc -l` ))
if [[ "$a" -eq 0 ]]; then
    sudo systemctl restart TEMPLATE_PROCESS
fi