#!/bin/bash

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
WPS_WEB_PATH='http://kdl.cc.ksosoft.com/wps-community/download/6757/wps-office_10.1.0.6757_amd64.deb'
echo $WPS_WEB_PATH

down_install_apps $WPS_WEB_PATH

#下载wps字体文件并安装
TTF_WEB_PATH='http://httpredir.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb'

down_install_apps $TTF_WEB_PATH

popd > /dev/null
