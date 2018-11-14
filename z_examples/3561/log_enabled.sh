#! /bin/bash
adb root
adb remount
adb shell setprop persist.logd.enabled 1
adb shell setprop persist.log.tag V 
#adb shell rm -rf cameradump_VDO
#adb shell setprop debug.VDO.dump 1
#adb shell setprop debug.camnode.dump.2 1
#adb shell setprop debug.camnode.dump.41 1
