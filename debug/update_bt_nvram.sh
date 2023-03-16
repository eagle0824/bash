#! /bin/bash

#compile audiocustparam and libcustom_nvram
mmm vendor/mediatek/proprietary/external/audiocustparam/ -B
mmm vendor/mediatek/proprietary/external/nvram/libcustom_nvram/ -B

adb root
adb remount

#update so to system
adb push out/target/product/evb3561t_66_m0/system/lib/libaudiocustparam.so /system/lib/
adb push out/target/product/evb3561t_66_m0/system/lib64/libaudiocustparam.so /system/lib64/

adb push out/target/product/evb3561t_66_m0/system/lib/libcustom_nvram.so /system/lib/
adb push out/target/product/evb3561t_66_m0/system/lib64/libcustom_nvram.so /system/lib64/

#delete nvram data
adb shell rm -rf /data/nvram/media/

adb shell sync
adb shell reboot
