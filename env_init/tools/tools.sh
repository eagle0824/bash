#!/bin/bash

#Ubuntu下UML工具
sudo apt-get install dia

#mediainfo 查看工具
sudo apt-get install mediainfo mediainfo-gui

WGET_CMD=wget
DIR_TOOLS=$(pwd)/tools
echo $DIR_TOOLS

function down_install_apps() {
    if [ ! -f $DIR_TOOLS/$(basename $1) ]; then
        $WGET_CMD $1
    fi

    if [ -f $DIR_TOOLS/$(basename $1) ]; then
        echo $DIR_TOOLS/$(basename $1)
        sudo chmod +x $DIR_TOOLS/$(basename $1)
        sudo dpkg -i $DIR_TOOLS/$(basename $1)
    fi
}

#安装wine,window软件运行环境.
#sudo apt-get install wine

pushd $DIR_TOOLS > /dev/null

#下载wps并安装
if [ -z $(which wps) ]; then

    WPS_WEB_PATH='http://kdl.cc.ksosoft.com/wps-community/download/6757/wps-office_10.1.0.6757_amd64.deb'
    echo $WPS_WEB_PATH

    down_install_apps $WPS_WEB_PATH
fi

#下载wps字体文件并安装
TTF_WEB_PATH='http://httpredir.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb'

down_install_apps $TTF_WEB_PATH

popd > /dev/null

#添加wps字体
WPS_FONTS='/usr/share/fonts/wps_symbol_fonts'
if [ ! -d $WPS_FONTS ]; then
    WPS_DIR=$(find ./ -name wps_symbol_fonts -type d)
    sudo cp $WPS_DIR $WPS_FONTS -rf
    pushd $WPS_FONTS
    sudo chmod 644 *
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache
    popd > /dev/null
fi

#卸载LibreOffice
#if [ -n $(which libreoffice) ]; then
    sudo apt-get remove libreoffice-common
    sudo apt-get remove libreoffice
#fi

#install chrome 浏览器
#加载源列表
sudo sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
#导入谷歌公钥
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
#更新源
sudo apt-get update
#安装chrome浏览器
sudo apt-get install google-chrome-stable

#pcm打开软件
#sudo apt-get install audacity
