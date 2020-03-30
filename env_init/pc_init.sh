#!/bin/bash

#============  define function start ===============
function update_apt_source() {
    version=`cat /etc/issue | awk '{print $2}'`
    version=${version:0:5}
    #echo $version
    case $version in
        12.04)
            echo 12.04
            sudo echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-backports main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-proposed main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-security main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-updates main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-backports main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-proposed main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-security main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-updates main multiverse restricted universe">/tmp/apt_source
            sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
            sudo mv /tmp/apt_source /etc/apt/sources.list
        ;;
        14.04)
            echo 14.04
            echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-backports main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-proposed main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-security main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-updates main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-backports main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-proposed main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-security main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-updates main multiverse restricted universe">/tmp/apt_source
            sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
            sudo mv /tmp/apt_source /etc/apt/sources.list
        ;;
        16.04)
            echo 16.04
            echo "deb http://mirrors.tuna.tsinghua.ddu.cn/ubuntu/ xenial main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main multiverse restricted universe">/tmp/apt_source
            sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
            sudo mv /tmp/apt_source /etc/apt/sources.list
        ;;
        *)
            echo not handle ubuntu version!
            ;;
    esac
}

#update openjdk source
function update_openjdk_source() {
    check_software openjdk-8-jdk
    if [ $? -eq 0 ]; then
        sudo apt-get-repository ppa:openjdk-r/ppa
    fi
}
#update oracle source
function update_oracle_java_source() {
    check_software oracle-java8-installer
    if [ $? -eq 0 ]; then
        sudo add-apt-repository ppa:webupd8team/java
    fi
}

#if has software return 1 else return 0
function check_software() {
    ret=`sudo apt-cache search $1 | awk '{print $1}'`
    if [ "$ret" = "$1" ]; then
        return 1
    else
        return 0
    fi
}

#update java version
function select_java_version() {
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
    sudo update-alternatives --config jar
    sudo update-alternatives --config javadoc
    sudo update-alternatives --config javah
    sudo update-alternatives --config javap
    sudo update-alternatives --config javaw
}


#============  define function end ===============


#更新/etc/apt/sources.list
#update_apt_source

#添加git-core
#sudo add-apt-repository ppa:git-core/ppa

#更新jdk
#update_oracle_java_source

#更新vim源
#sudo add-apt-repository ppa:jonathonf/vim

sudo apt-get update

CURRENT_PATH=$(pwd)
echo $CURRENT_PATH

#normal software
sudo apt-get install ssh meld unrar tar rar zip tree
sudo apt-get git-core

#vim
sudo apt-get install vim exuberant-ctags cscope
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp $CURRENT_PATH/vim/vimrc ~/.vimrc
# pluginstall must vim then input 
# :PluginInstall


#install minicom
sudo apt-get install minicom

#当用用户添加到dialout组，有权限访问相关tty设备
sudo usermod -aG dialout $(whoami)

#metazone.bin编译器
sudo apt-get install hexedit

#选择java版本
#select_java_version

#工作目录相关配置以及环境搭建
./workspace.sh
