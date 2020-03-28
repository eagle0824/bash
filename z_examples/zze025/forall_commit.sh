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
        #添加修改
        git add ./*
        #提交记录
        git cm -m "update applicationid accroiding to overlay priority"
        #提交哪个分支
        git push origin customer_master
        #git status 
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
