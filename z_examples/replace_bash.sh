#!/bin/bash

# get all dir. absolute paht is perfect
echo "dir is :" $1
prex='.java'

function findFile(){
local path=$1

for file in $path/*
do
    if [ -d $file ] ;then
        echo $file
        findFile $file
    elif [ -f $file ]; then  
        local len=${#file} 
        local sublen=${#prex} 
        if [ $prex == ${file:len-sublen:len} ] ; then
            sedFile $file
        fi
    fi
    done

}

function sedFile() {
    local file=$1
    echo $file;
    sed -i 's/com.android.settings/com.imotor.settings/g' $file
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
