#!/bin/bash

REPO_REPOSITORY=git://192.168.1.152/git/tools/repo.git
#/work/tools/repo
REPO_PATH=$TOOL_PATH/repo

if [ ! -d $REPO_PATH ]; then

    pushd $TOOL_PATH > /dev/null
    #从服务器下载repo到/work/tools/目录
    git_clone $REPO_REPOSITORY
    popd > /dev/null
fi

if [ -L $USER_BIN_PATH/repo ]; then
    rm $USER_BIN_PATH/repo
fi

ln -s $REPO_PATH/repo $USER_BIN_PATH/repo


#添加环境变量REPO_URL
if grep -q "REPO_URL" "$ALIAS_BASH"; then
    sed -i '/'"REPO_URL"'/d' $ALIAS_BASH
fi

sleep 1
#repo_url="export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'"
repo_url="export REPO_URL='$REPO_REPOSITORY'"
echo $repo_url>> $ALIAS_BASH

source $ALIAS_BASH
