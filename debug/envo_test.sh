#! /bin/bash

MAX=10
count=0

function enterEnvo() {
    adb shell am broadcast -a com.clw.backcar.ACTION_START
    sleep 2 
    adb shell am broadcast -a com.clw.backcar.ACTION_STOP
}

function rand(){
    min=$1  
    max=$(($2-$min+1))  
    num=$(date +%s%N)  
    echo $(($num%$max+$min))  
}  

if [[ $1 -ne 0 ]]; then
    MAX=$1
fi

echo $MAX

last=0

while ([ $count -le $MAX ]);do
    rnd=$(rand 1 100)  
    num=$(( $rnd % 3 ))
    if [[ $num -ne 0 ]]; then
        last=$num
    fi
    case $num in
        *)
            enterEnvo
            adb shell dumpsys meminfo com.clw.envo360
            ;;
    esac
    echo " do action index $count"
    count=`expr $count + 1`
done
