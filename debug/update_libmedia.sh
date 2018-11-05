#!/bin/bash

mmm ./frameworks/av/media/libmedia/

adb root
adb remount

adb push out/target/product/evb3561t_66_m0/system/lib/libmedia.so /system/lib/
adb push out/target/product/evb3561t_66_m0/system/lib64/libmedia.so /system/lib64/

adb shell sync
adb shell reboot
