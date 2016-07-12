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
            echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main multiverse restricted universe
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
function update_java_version() {
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
    sudo update-alternatives --config jar
    sudo update-alternatives --config javadoc
    sudo update-alternatives --config javah
    sudo update-alternatives --config javap
    sudo update-alternatives --config javaw
}


#============  define function end ===============

#update /etc/apt/sources.list
#update_apt_source

#update git sources
#sudo add-apt-repository ppa:git-core/ppa

#update_openjdk_source
#update_oracle_java_source

sudo apt-get update

#sudo apt-get install oracle-java8-installer
#sudo apt-get intall openjdk-8-jdk

#vim 
sudo apt-get install vim ctags cscope

#normal software
sudo apt-get install ssh git meld tar rar zip 


#================== git config start =================
#set name change name with your name
git config --global user.name name

#set email chage email with your email
git config --global user.email email

#set default editor
git config --global core.editor vim

#set alias
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br "branch -a"
git config --global alias.cm commit
git config --global alias.df diff

#diff ignore ^M
git config --global core.whitespace cr-at-eol

#set git diff/status color
git config --global color.status auto
git config --global color.diff auto

#================== git config end =================

#android comple software
#sudo apt-get install flex bison gperf build-essential libesd0-dev libwxgtk2.6-dev zlib1g-dev libx11-dev libncurses5-dev genext2fs u-boot-tools gnupg build-essential curl libc6-dev libncurses5-dev:i386 x11proto-core-dev libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev:i386 libzip-dev

#install minicom
sudo apt-get install minicom

#add current user to dialout group
#sudo usermod -aG dialout $(whoami)

#update used java version

#update_java_version


