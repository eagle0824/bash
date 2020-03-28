#! /bin/bash
#gradle assembleRelease

adb root && adb remount

adb push ./out/target/product/mt2712/system/lib64/libcalibrate.so /system/lib64/
adb push ./out/target/product/mt2712/system/lib/libcalibrate.so /system/lib/

adb push ./out/target/product/mt2712/system/lib64/libts_calibrate.so /system/lib64/
adb push ./out/target/product/mt2712/system/lib/libts_calibrate.so /system/lib/

adb push out/target/product/mt2712/system/app/AndroidCalibrate/AndroidCalibrate.apk /system/app/AndroidCalibrate/

adb shell reboot
