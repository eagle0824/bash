#! /bin/bash

mmm ./vendor/imotor/proprietary/services/

adb root && adb remount

if [ "$1" = "32" ]; then
    adb push out/target/product/mt2712/system/framework/oat/arm/com.imotor.services.vdex /system/framework/oat/arm/
    adb push out/target/product/mt2712/system/framework/oat/arm/com.imotor.services.odex /system/framework/oat/arm/
    adb push out/target/product/mt2712/system/framework/com.imotor.services.jar /system/framework/
else
    adb push out/target/product/mt2712/system/framework/oat/arm64/com.imotor.services.vdex /system/framework/oat/arm64/
    adb push out/target/product/mt2712/system/framework/oat/arm64/com.imotor.services.odex /system/framework/oat/arm64/
    adb push out/target/product/mt2712/system/framework/com.imotor.services.jar /system/framework/
fi

adb shell sync && adb shell reboot
