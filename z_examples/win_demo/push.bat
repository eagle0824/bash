adb root
adb remount
pause

adb push ./system/bin/gocsdk /system/bin/gocsdk
adb shell chmod 777 /system/bin/gocsdk
adb push ./system/lib/libbt_goc.so /system/lib
adb push ./system/lib64/libbt_goc.so /system/lib64
::adb push ./vendor/lib/libwapm.so /vendor/lib
::adb push ./vendor/lib64/libwapm.so /vendor/lib64
::
adb shell sync
pause
adb shell reboot
