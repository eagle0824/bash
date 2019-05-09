#! /bin/bash
adb root
adb remount

adb shell rm /sdcard/audio_dump/*

adb shell setprop streamout.pcm.dump 1
adb shell setprop streamin.pcm.dump 1
adb shell setprop streamhfp.pcm.dump 1

adb shell setprop persist.log.tag V 
