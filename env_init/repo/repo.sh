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

#软链接到~/bin/repo, ~/bin要添加到PATH
if [ -L $USER_BIN_PATH/repo ]; then
    rm $USER_BIN_PATH/repo
fi

#ln -s $REPO_PATH/repo $USER_BIN_PATH/repo


#添加环境变量REPO_URL
if grep -q "REPO_URL" "$ALIAS_BASH"; then
    sed -i '/'"REPO_URL"'/d' $ALIAS_BASH
fi

if grep -q "REPO_PATH" "$ALIAS_BASH"; then
    sed -i '/'"REPO_PATH"'/d' $ALIAS_BASH
fi

sleep 1
#repo_url="export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'"
repo_url="export REPO_URL='$REPO_REPOSITORY'"
repo_path="REPO_PATH='$REPO_PATH'"
repo_export_path='export PATH=$REPO_PATH:$PATH'

echo $repo_url>> $ALIAS_BASH
echo $repo_path>> $ALIAS_BASH
echo $repo_export_path>> $ALIAS_BASH

source $ALIAS_BASH
