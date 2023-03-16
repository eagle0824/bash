#! /bin/bash

echo $1

module=$1

pushd vendor/themes/packages/apps/$module

gradle assembleRelease

mm

popd

adb root && adb remount

adb push out/target/product/mt2712/vendor/overlay/$module-overlay.apk /vendor/overlay/

#adb shell sync && adb shell reboot
