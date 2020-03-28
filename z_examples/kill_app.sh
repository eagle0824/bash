# /bin/bash
adb root && adb remount

echo $1

pid=`adb shell ps -A | grep $1 | awk '{print $2}'`
echo $pid

adb shell kill -9 $pid
