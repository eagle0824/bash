#! /bin/bash

MAX=10
count=0

function enterEnvo() {
    adb shell am broadcast -a com.clw.backcar.ACTION_START
    sleep 2 
    adb shell am broadcast -a com.clw.backcar.ACTION_STOP
}

function startAvin() {
    adb shell am start -n com.clw.avin/.AuxPlayActivity
    sleep 1 
}

function startStream() {
    adb shell am start -n com.imotor.streamcamera/.MainActivity 
    sleep 1 
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
        0)
            enterEnvo
            adb shell dumpsys meminfo com.imotor.streamcamera
            ;;
        1)
            if ([ $last -eq 1 ]); then 
                adb shell input keyevent 4 
                sleep 1
            fi
            startAvin
            ;;
        2)
            if ([ $last -eq 2 ]); then 
                adb shell input keyevent 4 
                sleep 1
            fi 
            startStream
            ;;
    esac
    echo " do action index $count"
    count=`expr $count + 1`
done

if ([ "$last" -eq 2 ] || [ "$last" -eq 1 ]); then 
    adb shell input keyevent 4 
    sleep 1
fi
