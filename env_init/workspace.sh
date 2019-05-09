#!/bin/bash

#工作目录/work是默认的workspace
#如果不存在此目录需要创建或设为其他目录
WORK_PATH=/work

IMOTOR_PATH=$WORK_PATH/imotor

#工具相关文件目录
TOOL_PATH=$WORK_PATH/imotor/tools

#bin文件放置目录
USER_BIN_PATH=~/bin
ALIAS_BASH=~/.bashrc

CMD_GIT=git

function git_clone() {
    $CMD_GIT clone $1
}

function git_pull() {
    $CMD_GIT pull
}

#COMMIT_IMOTOR_ADD='#start imotor-add start'
#COMMIT_IMOTOR_END='#start imotor-add end'

#系统安装时/work/是root用户
#所以修改/wrok/目录权限为当前当前用户

#owner,group
#修改WORK_PATH权限为
WORK_OWNER=$(ls -al $(dirname $WORK_PATH) | awk '$9=="'$(basename $WORK_PATH)'" {print $3}')

if [ $WORK_OWNER != $(whoami) ]; then
    sudo chown -R $(whoami):$(whoami) $WORK_PATH
fi

#修改/work权限为777
if [ ! -w $WORK_PATH -o ! -r $WORK_PATH -o ! -x $WORK_PATH  ]; then
    chmod 777 $WORK_PATH
fi

if [ ! -d $TOOL_PATH ]; then
    mkdir $TOOL_PATH -p
fi

if [ ! -d $USER_BIN_PATH ]; then
    mkdir $USER_BIN_PATH
fi

#初始化java
#. java/java.sh

#git配置
#. git_config.sh

#初始化android相关配置
. android/android.sh

#检查是否配置ssh-key
if [ ! -d ~/.ssh ]; then
    echo " -------------error--------------\n没有~.ssh目录, 请确认git_config.sh中user.name,user.email已经配置,\n
    并通过下面指令生成ssh-key并提交id_rsa.pub给系统管理员添加权限\n
    ssh-keygen -t rsa \n"
    exit
fi

#初始化repo
. repo/repo.sh

#初始化imotor
. imotor/imotor.sh

#安装部分需要下载自行安装的软件
. tools/tools.sh
