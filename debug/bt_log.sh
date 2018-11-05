#! /bin/bash
adb root
adb remount
adb shell rm -rf /sdcard/mtklog/
adb shell setprop streamin.epl.dump 1
adb shell setprop streamin.pcm.dump 1
adb shell setprop streamout.pcm.dump 1
