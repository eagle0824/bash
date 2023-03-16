#! /bin/bash

PROJECT_CODE_NAME="device/mediatek/mt2712"

function gettop() {
    local TOPFILE=$(pwd)
    echo ${TOPFILE} | awk -F"/${PROJECT_CODE_NAME}/patch" '{print $1}'
}

CODE_SPACE=$(gettop)
PATCH_DIR="${CODE_SPACE}/${PROJECT_CODE_NAME}/patch/"
DIR_LIST=$(find ${PATCH_DIR} -name *.patch | xargs -i dirname {} | sort -u)
SUBS_NUM=$(echo ${#PATCH_DIR})

for var in $DIR_LIST
do
    patch_dir=$(echo ${var:${SUBS_NUM}})
    code_dir=$CODE_SPACE/$patch_dir
    pushd $code_dir
    git clean -dqfx
    git checkout ./*
    git status
    popd >/dev/null
done
