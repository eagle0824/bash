#! /bin/bash
adb root
adb remount

adb shell chmod 600 /dev/block/mmcblk0p*
adb shell chmod 660 /dev/block/mmcblk0p16
