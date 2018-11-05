#!/bin/bash

##更新imotor相关的工具仓库或文档说明仓库
if [ ! -d $TOOL_PATH ]; then
    mkdir $TOOL_PATH -p
fi

if [ ! -d $IMOTOR_PATH/doc ]; then
    mkdir $IMOTOR_PATH/doc -p
fi

REPO_CONFIG_PATH=$(find ./ -name repositories.conf)
#echo $REPO_CONFIG_PATH 

for repository in $(awk '{print $1}' $REPO_CONFIG_PATH)
do

    if [ ${repository:0:1} = "#" ]; then
        continue
    fi

    dir_name=$(basename $(dirname $repository))
    #echo "$dir_name"

    if [ $dir_name = "tools" -o $dir_name = "doc" ]; then
        dir_path=$IMOTOR_PATH"/"$dir_name
    else
        dir_path=$IMOTOR_PATH
    fi

    pushd $dir_path > /dev/null
    git_clone $repository 
    popd > /dev/null
done

#下载imotor相关仓库
#for repository in $(awk '{
#    if($1=="imotor") print $2
#}' $REPO_CONFIG_PATH)
#do
#    pushd $IMOTOR_PATH
#    git_clone $repository 
#    popd
#done
