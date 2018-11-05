#!/bin/bash

pushd $ANDROID_SDK_HOME/platform-tools/
sudo ./adb kill-server
sudo ./adb start-server
popd - > /dev/null
