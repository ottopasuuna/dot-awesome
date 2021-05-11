#! /bin/bash

if [ -z $1 ]; then
    config_file=~/.config/awesome/rc.lua
else
    config_file=$1
fi
Xephyr -ac -br -noreset -screen 1200x720 :1.0 &
ZEPHYR_PID=$!
sleep 1
DISPLAY=:1.0 awesome -c $config_file
kill $ZEPHYR_PID

