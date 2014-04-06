#!/bin/bash

# get all dir. absolute paht is perfect
echo $1

function findFile(){
local path=$1
local sufix=.apk
local sublen=${#sufix}

for sub in $path/* 
do
	uri=$sub
	local len=${#uri}	
	local slen=($len-$sublen)
	if [ $str == ${uri:slen:len} ] ; then
		echo $uri
	fi

#	if [ -f $sub ] ; then
#		echo $sub
#		local len=${#sub}	
#		local slen=($len-$sublen)
#		if [ $str == ${sub:slen:len} ] ; then
#			echo "file is $sub"
#			rm $sub
#		fi
#		. runsed.sh $sub
#	elif [ -d $path ] ; then
#		#echo "dir is $path"
#		findFile $sub
#	fi
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
