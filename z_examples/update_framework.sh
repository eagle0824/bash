#! /bin/bash

mmm ./frameworks/base

adb root && adb remount

adb push out/target/product/mt2712/system/framework/framework.jar /system/framework/
adb push out/target/product/mt2712/system/framework/boot-framework.vdex /system/framework/

adb push out/target/product/mt2712/system/framework/arm64/boot-framework.art /system/framework/arm64/
adb push out/target/product/mt2712/system/framework/arm64/boot-framework.art.rel /system/framework/arm64/
adb push out/target/product/mt2712/system/framework/arm64/boot-framework.oat /system/framework/arm64/

adb shell sync
adb shell reboot
