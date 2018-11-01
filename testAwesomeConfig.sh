#! /bin/bash

Xephyr -ac -br -noreset -screen 1200x720 :1.0 &
ZEPHYR_PID=$!
sleep 1
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua
kill $ZEPHYR_PID

