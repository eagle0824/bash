#!/bin/bash

# get all dir. absolute paht is perfect
#echo "dir is :" $1
fileName='config'

function findFile(){
local path=$1
pushd $path
list=($(find ./ -name .git -type d))

for dir in "${list[@]}"
do
    #echo $dir
    sedFile $dir/$fileName
done

popd
}

function sedFile() {
    local file=$1
    echo $file
    if [ -f $file ] ; then
        sed -i 's/192.168.1.152/218.94.135.182/g' $file
        git stash && git pull
    fi
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
