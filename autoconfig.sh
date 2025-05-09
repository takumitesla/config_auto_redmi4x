#!/bin/bash
clear
pkg install figlet -y

figlet AUTO_CONFIG
echo "by takumi tesla"

start_config(){
    clear
    echo "phase 1"
    sleep 1
    echo "setprop service.adb.tcp.port=5555" >> /system/
    
}

if [ -x /system/xbin/su ] || [ -x /system/bin/su ] || [ -x /sbin/su ] || [ -x /system/su ]; then
    echo "The device is rooted."
    sleep 1
    echo "start program.."
    sleep 1
    start_config
else
    echo "are you rooted?"
fi
