#! /bin/bash

IMOTOR_REPOSITORIES=(
build_scripts 
bootable/bootloader/lk
kernel-4.9
device/mediatek/mt2712
vendor/mediatek/mt2712/fastRvc

packages/services/Car
frameworks/base
frameworks/av
vendor/imotor
platform/manifest
build/make
)
#build_scripts gitolite@192.168.1.152:imotor/tools/build_scripts
#kernel gitolite@192.168.1.152:zze025/kernel-4.9

for repository in ${IMOTOR_REPOSITORIES[@]}
do
    echo "update repository: $repository"
    pushd ${PWD}/${repository}> /dev/null
    git pull
    popd > /dev/null
done
