#! /bin/bash

REPOSITORY_PREX='gitolite@192.168.1.152:zze025/'

IMOTOR_REPOSITORIES=(
bootable/bootloader/lk
kernel-4.9
device/mediatek/mt2712
vendor/mediatek/mt2712/fastRvc
)

#build_scripts gitolite@192.168.1.152:imotor/tools/build_scripts
IMOTOR_UPDATE_REPOSITORIES=(
build_scripts 
)

PWD=$(pwd)
BACKUP=$PWD/backup

#delete backup dir
#create backup dir if no
if [ -d $BACKUP ] ; then
    rm $BACKUP -rf
fi

mkdir $BACKUP -p

for repository in ${IMOTOR_REPOSITORIES[@]}
do
    echo ${repository}
    dir_name=$(dirname $BACKUP/${repository})
    mkdir -p $dir_name
    if [ -d ${PWD}/${repository} ] ; then
        mv ${PWD}/${repository} $dir_name
    else
        echo "dir : ${PWD}/${repository} not exist!"
    fi
done

repo sync

for repository in ${IMOTOR_REPOSITORIES[@]}
do
    rep_path=${PWD}/${repository}
    echo "rep_path $rep_path"

    if [ -d $rep_path ]; then
        rm -rf $rep_path
    fi

    dir_name=$(dirname $rep_path)

    backup_path=${BACKUP}/${repository}

    echo $dir_name

    if [ -d $backup_path ]; then
        mv $backup_path $dir_name
    else
        echo "not got repository from backup so reclone"
        pushd $dir_name > /dev/null
        git clone $REPOSITORY_PREX$repository
        popd > /dev/null
    fi
done

#delete backup dir
#rm $BACKUP -rf

#for repository in ${IMOTOR_UPDATE_REPOSITORIES[@]}
#do
#    dir_name=${PWD}/${repository}
#    echo "update repository $dir_name"
#    pushd $dir_name > /dev/null
#    git pull
#    popd > /dev/null
#done
