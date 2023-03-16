#!/bin/bash

code_pref=/work2/rk3566/
target_pref=~/Desktop/code/
#array=(frameworks/av/include frameworks/native/include frameworks/av/media/libaudioclient/include frameworks/av/media/libaudioprocessing/include frameworks/av/media/libmedia/include frameworks/av/media/libstagefright/include frameworks/av/media/libmediaextractor/include hardware/libhardware/include hardware/libhardware_legacy/include bionic/libc/kernel/uapi bionic/libc/include hardware/mediatek/bt/bluedroid)

#array=(packages/apps/Bluetooth frameworks/base/core/java/android/bluetooth system/bt/binder)

array=(
system/bt/binder/android/bluetooth
system/bt/binder/android/os
frameworks/base/core/jni/include/android_runtime
system/bt/include/hardware
system/core/base/include/android-base
system/core/libsystem/include
system/core/libprocessgroup
system/core/include
system/media/audio/include
system/bt/types/bluetooth
system/core/libcutils/include/cutils
hardware/libhardware
hardware/libhardware_legacy
libnativehelper/header_only_include/nativehelper
libnativehelper/include/nativehelper
libnativehelper/platform_include/nativehelper
external/libchrome
)

function copy_link_file(){
local path=$1

for sub in $path/* 
do
    #echo $sub
	if [ -L $sub ] ; then
		echo "link ==> $sub"
	fi

done
}

for path in ${array[@]}
do
    source_dir=${code_pref}${path}
    target_dir=${target_pref}${path}

    if [ ! -d $source_dir ]; then
        echo "not find dir $source_dir"
        continue
    fi

    if [ ! -d $target_dir ]; then
        mkdir $target_dir -p
    else 
        rm -rf $target_dir/*
    fi

    cp -Lvr $source_dir/* $target_dir -rf

    #echo ${target_dir}
    #copy_link_file ${source_dir}

done
