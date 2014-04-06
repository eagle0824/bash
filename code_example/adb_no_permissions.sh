#!/bin/bash


cd $ANDROID_SDK_HOME/platform-tools/
sudo ./adb kill-server
sudo ./adb start-server
cd - > /dev/null
