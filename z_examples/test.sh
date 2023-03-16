#!/bin/bash

# we have less than 3 arguments,Print the help text:

count=`adb shell getprop persist.sys.test.count1`

echo "=1===>${count}"

echo "====>${count}"


count=`expr $count + 1`

echo "====>${count};"

adb shell setprop persist.sys.test.count ${count}



