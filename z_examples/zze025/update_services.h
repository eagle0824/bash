#! /bin/bash

mmm ./frameworks/base/services

adb root && adb remount

adb push out/target/product/mt2712/system/framework/services.jar.prof /system/framework/
adb push out/target/product/mt2712/system/framework/services.jar /system/framework/
adb push out/target/product/mt2712/system/framework/services.core.jar /system/framework/

adb shell sync && adb shell reboot
