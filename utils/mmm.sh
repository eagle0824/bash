#!/bin/bash

function mhelp(){
cat << HELP

			Help document

	m_install		:params same as mmm,mmm app and install it's apk to device
	m_push			:params same as mmm,mmm app and push it's apk to device
	m_framework		:no params, mmm frameworks/base and push framework.jar to device
	m_framework-res		:no params, mmm frameworks/base/core/res and push framework-res.apk to device
	
HELP
}

function m_install(){
	local path=$1
	if [ -z "$path" ]
		then
			mhelp
			return
	fi
	local name=$(echo $(grep -e "LOCAL_PACKAGE_NAME" $path/Android.mk) | sed "s/LOCAL_PACKAGE_NAME := //")
	mmm $path && adb remount && adb install -r out/target/product/$TARGET_PRODUCT/system/app/$name.apk 
}

function m_push(){
	local path=$1
	if [ -z "$path" ]
		then
			mhelp
			return
	fi
	local name=$(echo $(grep -e "LOCAL_PACKAGE_NAME" $path/Android.mk) | sed "s/LOCAL_PACKAGE_NAME := //")
	mmm $path && adb remount && adb push out/target/product/$TARGET_PRODUCT/system/app/$name.apk /system/app
}

function m_framework(){
	local path='./frameworks/base/'
	mmm $path && adb remount && adb push out/target/product/$TARGET_PRODUCT/system/framework/framework.jar /system/framework && adb shell sync
}

function m_framework-res(){
	local path=./frameworks/base/core/res/
	mmm $path && adb remount && adb push out/target/product/$TARGET_PRODUCT/system/framework/framework-res.apk /system/framework && adb shell sync
}
