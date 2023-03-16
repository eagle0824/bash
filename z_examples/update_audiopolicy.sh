#! /bin/bash

mmm ./frameworks/av/services/audiopolicy/

adb root && adb remount

adb push ./out/target/product/mt2712/system/lib64/libaudiopolicymanagerdefault.so /system/lib64/ 
adb push ./out/target/product/mt2712/system/lib64/libaudiopolicyservice.so /system/lib64/
adb push ./out/target/product/mt2712/system/lib64/libaudiopolicymanager.so /system/lib64/
adb push ./out/target/product/mt2712/system/lib64/libaudiopolicyenginedefault.so /system/lib64/

adb push ./out/target/product/mt2712/system/lib/libaudiopolicymanagerdefault.so /system/lib/
adb push ./out/target/product/mt2712/system/lib/libaudiopolicyenginedefault.so /system/lib/
adb push ./out/target/product/mt2712/system/lib/libaudiopolicyservice.so /system/lib/
adb push ./out/target/product/mt2712/system/lib/libaudiopolicymanager.so /system/lib/

adb shell sync && adb shell reboot
