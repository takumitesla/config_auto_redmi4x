#!/bin/bash
clear
pkg install figlet -y

figlet AUTO_CONFIG
echo "by takumi tesla"

if [ -x /system/xbin/su ] || [ -x /system/bin/su ] || [ -x /sbin/su ] || [ -x /system/su ]; then
    echo "Perangkat sudah di-root!"
else
    echo "are you rooted?"
fi
