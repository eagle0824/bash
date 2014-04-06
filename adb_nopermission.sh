#!/bin/bash

#cd $ANDROID_SDK_HOME/platform-tools/
cd /work/tool/adt-bundle-linux-x86_64/sdk/platform-tools
sudo ./adb kill-server
sudo ./adb start-server
cd - 1> /dev/null
