#! /bin/bash

adb root && adb remount
#adb kill -9 pid; and $1 is key or package name
adb shell kill -9 `adb shell ps | grep $1 | awk 'NR==1{
print $2}'`
