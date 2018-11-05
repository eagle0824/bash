#!/bin/bash

#拷贝jdk_switcher到home/bin下面
if [ -f $USER_BIN_PATH/jdk_switcher ]; then
    rm $USER_BIN_PATH/jdk_switcher
fi

JDK_SWITCHER_PATH=$(find ./ -name jdk_switcher)

cp $JDK_SWITCHER_PATH $USER_BIN_PATH
