
# this command only run on first compile
#./device/mediatek/mt2712/patch/apply_patches.sh

. build/envsetup.sh
#2712H
#lunch car_mt2712_vp1_32-eng
lunch car_mt2712_vp1_32-userdebug
#lunch car_mt2712-userdebug
#lunch car_mt2712-eng
sdk use java 8.0.212-zulu
#2712E
#lunch car_mt2712_vp1-userdebug 
#2712P
#lunch car_mt2712_vp2-userdebug 
#2712M
#lunch car_mt2712_vp3-userdebug
