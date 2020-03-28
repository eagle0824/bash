#! /bin/bash

mmm ./frameworks/base/services

adb root && adb remount

#adb shell setprop persist.sys.install.no.warning false

if [ "$1" = "32" ]; then
    adb push out/target/product/mt2712/system/framework/oat/arm/services.odex /system/framework/oat/arm/
    adb push out/target/product/mt2712/system/framework/oat/arm/services.vdex /system/framework/oat/arm/
else
    adb push out/target/product/mt2712/system/framework/oat/arm64/services.odex /system/framework/oat/arm64/
    adb push out/target/product/mt2712/system/framework/oat/arm64/services.vdex /system/framework/oat/arm64/
fi
adb push out/target/product/mt2712/system/framework/services.jar.prof /system/framework/
adb push out/target/product/mt2712/system/framework/services.jar /system/framework/
adb push out/target/product/mt2712/system/framework/services.core.jar /system/framework/

#adb shell rm -rf /data/system/appops.xml

adb shell sync && adb shell reboot
