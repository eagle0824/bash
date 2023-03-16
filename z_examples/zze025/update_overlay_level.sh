#!/bin/bash

# get all dir. absolute paht is perfect
echo "dir is :" $1
#pref='.mk'
#pref='.xml'
#pref='.gradle'
prefs=('.mk' '.xml' '.gradle')


function findFile(){
local path=$1

for file in $path/*
do
    if [ -d $file ] ;then
        echo $file
        findFile $file
    elif [ -f $file ]; then  
        local len=${#file} 
        for pref in ${prefs[@]}
        do
            local sublen=${#pref} 
            if [ $pref == ${file:len-sublen:len} ] ; then
                sedFile $file
            fi
        done
    fi
    done

}

function sedFile() {
    local file=$1
    echo $file;
    #更新package name以及module name
    #sed -i 's/overlay200/overlay100/g' $file
    #更新优先级
    #sed -i 's/android:priority="200"/android:priority="100"/g' $file
}

function getCurrent(){
	/bin/pwd
}

if [ $# -eq 0 ] ; then
	findFile $(getCurrent) 
elif [ -n $1 ] ; then
	if [ $1 == "." -o $1 == "./" ] ; then
		findFile $(getCurrent)
	else
		path=$1
		findFile ${path%/}
		unset path
	fi
else
	echo "path is null!"
fi
