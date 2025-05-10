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

[9/5 22.52] Dr. Maxwell: /data/adb/service.d/autotermux.sh
[9/5 22.59] Dr. Maxwell: #!/system/bin/sh
sleep 55
am start -n com.termux/.app.TermuxActivity
exit 0
[9/5 22.59] Dr. Maxwell: /system/build.prop
[9/5 23.00] Dr. Maxwell: service.adb.tcp.port=5555
[9/5 23.00] Dr. Maxwell: /system/etc/init/autoboot.rc
[9/5 23.01] Dr. Maxwell: on charger
setprop sys.powerctl reboot
