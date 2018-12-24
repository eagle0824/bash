#!/bin/bash

#更新70-android.rules文件解决adb 设备识别不到的问题
ANDROID_RUNLES_FILE_NAME=70-android.rules
RULESD_DIR=/etc/udev/rules.d
ANDROID_RULES_PATH=$RULESD_DIR/$ANDROID_RUNLES_FILE_NAME

if [ ! -f $ANDROID_RULES_PATH ]; then
    FILE_PATH=$(find ./ -name $ANDROID_RUNLES_FILE_NAME)
    sudo cp $FILE_PATH $RULESD_DIR
fi

if [ ! -x $ANDROID_RULES_PATH -o ! -r $ANDROID_RULES_PATH ]; then
    sudo chmod a+rx /etc/udev/rules.d/70-android.rules
fi

sudo /etc/init.d/udev restart


# 添加sdk路径到.bashrc里面，解决adb找不到的问题
# android-sdk目录为/work/tools/android-sdk

#添加环境变量SDK_HOME
if grep -q "SDK_HOME" "$ALIAS_BASH"; then
    sed -i '/'"SDK_HOME"'/d' $ALIAS_BASH
fi

sleep 1

sdk_home='SDK_HOME=/work/tools/android-sdk'
sdk_path='export PATH=$SDK_HOME/tools:$SDK_HOME/platform-tools:$PATH'

echo $sdk_home >> $ALIAS_BASH
echo $sdk_path >> $ALIAS_BASH

source $ALIAS_BASH

#compile for mt2712
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip device-tree-compiler

#安装gradle
curl -s "https://get.sdkman.io" | bash
source ~/.bashrc
sdk install gradle 5.0
#sdk install java

#安装kotlin
#sudo snap install --classic kotlin
