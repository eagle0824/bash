#!/bin/bash

code_pref=/work/zze025/daily/target/
target_pref=~/Desktop/code/
#array=(frameworks/av/include frameworks/native/include frameworks/av/media/libaudioclient/include frameworks/av/media/libaudioprocessing/include frameworks/av/media/libmedia/include frameworks/av/media/libstagefright/include frameworks/av/media/libmediaextractor/include hardware/libhardware/include hardware/libhardware_legacy/include bionic/libc/kernel/uapi bionic/libc/include hardware/mediatek/bt/bluedroid)

#
array=(packages/apps/Bluetooth frameworks/base/core/java/android/bluetooth system/bt/binder)

function copy_link_file(){
local path=$1

for sub in $path/* 
do
    #echo $sub
	if [ -L $sub ] ; then
		echo $sub
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

    cp $source_dir/* $target_dir -rf

    #echo ${target_dir}
    copy_link_file ${source_dir}

done
