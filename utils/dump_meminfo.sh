#!/bin/bash

adb root && adb remount

echo "" > /tmp/meminfo.txt

while :
do 
    date
    #dumpsys meminfo com.percherry.roundadas >> $file
    adb shell procrank | tee -a /tmp/meminfo.txt
    #sleep 1 
    #adb shell top | tee -a /tmp/meminfo.txt
    sleep 3 

done
