#! /bin/bash

if [ "$1" = "" ] || [ "$1" = "reboot" ];then
    apps=(Envo360 StreamCamera AVIN reboot)
else
    apps=($@)
fi

basepath=$(cd `dirname $0`; pwd)

adb root && adb remount

reboot=0

for app in ${apps[@]}; do
    if [ "$app" = "reboot" ]; then
        ${reboot}=1
        continue
    fi
    mmm $basepath/packages/apps/$app
    case $app in
        Envo360)
            #update Envo360 apk
            adb push ./out/target/product/evb3561t_66_m0/data/app/$app/$app.apk /system/app/$app/$app.apk

            #update all so to /system/lib/
            #adb push out/target/product/evb3561t_66_m0/system/lib/libcam.MonoProc.so /system/lib/
            #adb push out/target/product/evb3561t_66_m0/system/lib/libenvo_ogles.so /system/lib/
            #adb push out/target/product/evb3561t_66_m0/system/lib/libMonoCamera.so /system/lib/
            #adb push out/target/product/evb3561t_66_m0/system/lib/libopencv_world.so /system/lib/
            #adb push out/target/product/evb3561t_66_m0/system/lib/libtbb.so /system/lib/
            #adb push out/target/product/evb3561t_66_m0/system/lib/libMonoAuth.so /system/lib/
            #adb push out/target/product/evb3561t_66_m0/system/lib/libim_envo_control.so /system/lib/

            #update all so /sytem/app/Envo360/lib/arm/
            adb push out/target/product/evb3561t_66_m0/system/lib/libcam.MonoProc.so /system/app/Envo360/lib/arm/
            adb push out/target/product/evb3561t_66_m0/system/lib/libenvo_ogles.so /system/app/Envo360/lib/arm/
            adb push out/target/product/evb3561t_66_m0/system/lib/libMonoCamera.so /system/app/Envo360/lib/arm/
            adb push out/target/product/evb3561t_66_m0/system/lib/libopencv_world.so /system/app/Envo360/lib/arm/
            adb push out/target/product/evb3561t_66_m0/system/lib/libtbb.so /system/app/Envo360/lib/arm/
            adb push out/target/product/evb3561t_66_m0/system/lib/libMonoAuth.so /system/app/Envo360/lib/arm/
            adb push out/target/product/evb3561t_66_m0/system/lib/libim_envo_control.so /system/app/Envo360/lib/arm/
            ;;
        *)
        adb push ./out/target/product/evb3561t_66_m0/system/app/$app/$app.apk /system/app/$app/$app.apk
            ;;
    esac
    echo "update $app successful!!!!!"
done 

adb shell sync

echo "...............$reboot .............."

if [ "$reboot" -eq "1" ];then
    adb shell reboot
fi
