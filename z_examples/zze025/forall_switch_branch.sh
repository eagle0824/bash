#!/bin/bash

# get all dir. absolute paht is perfect
echo $1

function findFile(){
local path=$1
local str=.xml.bak
local sublen=${#str}

for sub in $path/* 
do
	if [ -d $sub ] ; then
        echo $sub
        pushd $sub
        #git co master
        git co customer_master

        #git co -b customer_master
        #git push origin customer_master

        #git add ./*
        #git cm -m "init version"
        popd
	fi
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
