#!/bin/bash

# get all dir. absolute paht is perfect
echo $1

function findFile(){
local path=$1
local sufix=.png
local sublen=${#sufix}

for sub in $path/* 
do
	uri=$sub
	local len=${#uri}	
	local slen=($len-$sublen)
    echo $sub;

	#if [ $str == ${uri:slen:len} ] ; then
	#	echo $uri
	#fi
#
done
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
