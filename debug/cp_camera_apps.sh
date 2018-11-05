#! /bin/bash
echo $1
mkdir $1/camera/ -p
mkdir $1/camera/Envo360/lib/arm -p

path=$1/camera/

echo $path

cp out/target/product/evb3561t_66_m0/data/app/Envo360/Envo360.apk $path/Envo360/

cp out/target/product/evb3561t_66_m0/system/lib/libcam.MonoProc.so $path/Envo360/lib/arm/
cp out/target/product/evb3561t_66_m0/system/lib/libenvo_ogles.so $path/Envo360/lib/arm/
cp out/target/product/evb3561t_66_m0/system/lib/libMonoCamera.so $path/Envo360/lib/arm/
cp out/target/product/evb3561t_66_m0/system/lib/libopencv_world.so $path/Envo360/lib/arm/
cp out/target/product/evb3561t_66_m0/system/lib/libtbb.so $path/Envo360/lib/arm/
cp out/target/product/evb3561t_66_m0/system/lib/libMonoAuth.so $path/Envo360/lib/arm/
cp out/target/product/evb3561t_66_m0/system/lib/libim_envo_control.so $path/Envo360/lib/arm/


cp out/target/product/evb3561t_66_m0/system/app/AVIN/AVIN.apk $path
cp out/target/product/evb3561t_66_m0/system/app/StreamCamera/StreamCamera.apk $path
