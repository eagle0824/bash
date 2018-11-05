#!/bin/bash

current=$(/bin/pwd)

#echo $current
files=$(find $current -name *.apk)

if [ -f result.txt ]; then
    rm result.txt
fi


for file in $files
do
    echo $file
    for data in $($current/bin/aapt d badging $file | grep "package: name=\|application: label=")
    do
        #echo $data
        if [[ $data == *name=* ]]
        then
            pname=$data
        elif [[ $data == *icon=* ]]
        then
            iname=$data
        fi
    done

    #name='com.autonavi.amapauto'
    #get package name
    #echo $pname
    pname=${pname:6:`expr ${#pname} - 7`};

    #echo $iname
    #icon='res/drawable-mdpi-v4/welink.png'
    #get icon name
    iname=${iname##*/}
    iname=${iname:0:`expr ${#iname} - 1`};

    #get new icon name
    #replase . whth _
    name=${pname//./_}"_"$iname;

    #echo new icon name:$name
    echo $file >> result.txt
    echo $name >> result.txt
    echo  >> result.txt

done 
