#! /bin/bash

#compile api
mmm ./vendor/imotorapi/ -B
#package api
./vendor/imotorapi/makesdk.sh
#move jar to app
#cp ./vendor/imotorapi/sdk/imotorapi.jar /work/mtk356x/atc_356x/packages/apps/VolumeTest/libs/imotorapi.jar
cp ./vendor/imotorapi/sdk/imotorapi.jar /work/mtk356x/atc_356x/packages/apps/VehicleDemo/app/libs/imotorapi.jar
#compile app
#mmm ./packages/apps/VolumeTest/
mmm ./packages/apps/VehicleDemo/
#install app
#adb install -r out/target/product/evb3561t_66_m0/system/app/VolumeTest/VolumeTest.apk
#adb install -r out/target/product/evb3561t_66_m0/system/app/VehicleDemo/VehicleDemo.apk
