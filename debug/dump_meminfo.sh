#! /bin/bash

while true
do
time=$(date "+%Y%m%d-%H:%M:%S")

echo $time

#adb shell dumpsys meminfo system_server | tee /tmp/meminfo.txt
adb shell dumpsys meminfo com.clw.envo360 | tee -a /tmp/meminfo.txt

sleep 5 

done
