#! /bin/bash

mmm ./frameworks/base/packages/SettingsLib/
mmm ./packages/apps/IMSettings/
#mmm ./frameworks/base/packages/SystemUI/

adb root && adb remount

adb push out/target/product/mt2712/system/priv-app/IMSettings/IMSettings.apk /system/priv-app/IMSettings/
#adb push out/target/product/mt2712/system/priv-app/SystemUI/SystemUI.apk /system/priv-app/SystemUI/

adb shell sync

adb shell am force-stop com.imotor.settings
