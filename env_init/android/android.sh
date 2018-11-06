#!/bin/bash


ANDROID_RUNLES_FILE_NAME=70-android.rules
RULESD_DIR=/etc/udev/rules.d
ANDROID_RULES_PATH=$RULESD_DIR/$ANDROID_RUNLES_FILE_NAME

if [ ! -f $ANDROID_RULES_PATH ]; then
    FILE_PATH=$(find ./ -name $ANDROID_RUNLES_FILE_NAME)
    sudo cp $FILE_PATH $RULESD_DIR
fi

if [ ! -x $ANDROID_RULES_PATH ]; then
    sudo chmod a+rx /etc/udev/rules.d/70-android.rules
fi

sudo /etc/init.d/udev restart


