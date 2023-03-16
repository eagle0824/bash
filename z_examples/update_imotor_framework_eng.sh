#! /bin/bash

mmm ./vendor/imotor/proprietary/frameworks/

adb root && adb remount

adb push out/target/product/mt2712/system/framework/com.imotor.framework.jar /system/framework/

adb shell sync && adb shell reboot
