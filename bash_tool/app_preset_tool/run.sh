#! /bin/bash

permissions=("android.permission.READ_CONTACTS"
"android.permission.WRITE_CONTACTS"
"android.permission.READ_CALENDAR"
"android.permission.WRITE_CALENDAR"
"android.permission.SEND_SMS"
"android.permission.RECEIVE_SMS"
"android.permission.READ_SMS"
"android.permission.RECEIVE_WAP_PUSH"
"android.permission.RECEIVE_MMS"
"android.permission.READ_CELL_BROADCASTS"
"android.permission.READ_EXTERNAL_STORAGE"
"android.permission.WRITE_EXTERNAL_STORAGE"
"android.permission.ACCESS_FINE_LOCATION"
"android.permission.ACCESS_COARSE_LOCATION"
"android.permission.ACCESS_IMS_CALL_SERVICE"
"android.permission.READ_CALL_LOG"
"android.permission.WRITE_CALL_LOG"
"android.permission.PROCESS_OUTGOING_CALLS"
"android.permission.READ_PHONE_STATE"
"android.permission.READ_PHONE_NUMBERS"
"android.permission.CALL_PHONE"
"com.android.voicemail.permission.ADD_VOICEMAIL"
"android.permission.USE_SIP"
"android.permission.ANSWER_PHONE_CALLS"
"android.permission.MANAGE_OWN_CALLS"
"android.permission.ACCEPT_HANDOVER"
"android.permission.RECORD_AUDIO"
"android.permission.ACCESS_UCE_PRESENCE_SERVICE"
"android.permission.ACCESS_UCE_OPTIONS_SERVICE"
"android.permission.CAMERA"
"android.permission.BODY_SENSORS"
"android.permission.ACCESS_MEDIA_LOCATION"
"android.permission.ACCESS_BACKGROUND_LOCATION")


function get_abs_path()
{
    if [ -z "$1" -o "$1" = "." -o "$1" = "./" ]
    then
        /bin/pwd
    else
        cd $1
        /bin/pwd
        cd - > /dev/null
    fi  
}

function create_app_mk()
{
    local path=$1
    local name=$2
    echo "$name ==> create ${name,,}.mk"
    echo 'PRODUCT_PACKAGES += \' > $path/${name,,}.mk
    echo -e "\t$name \\" >> $path/${name,,}.mk
}

function create_android_mk()
{
    local path=$1
    local name=$2
    echo "$name ==> create Android.mk"
    echo '
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)' > $path/Android.mk

echo "LOCAL_MODULE := $name">> $path/Android.mk

echo 'LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
#LOCAL_CERTIFICATE := platform
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_PATH := $(TARGET_OUT)/app
include $(BUILD_PREBUILT)' >> $path/Android.mk
}

function parse_app_so() {
    local app_path=$1
    local name=$2
    local target_dir=$3
    local tmp_dir=/tmp/$name
    echo "$name ==> parse app so"

    cp $app_path $tmp_dir
    unzip $app_path -d $tmp_dir > /dev/null

    #arm64-v8a
    local arm64_path=$tmp_dir/lib/arm64-v8a
    if [ -d $arm64_path ] ; then
        mkdir $target_dir/system/app/$name/lib/arm64 -p
        cp $arm64_path/* $target_dir/system/app/$name/lib/arm64/
    fi

    local arm_path=$tmp_dir/lib/armeabi-v7a
    if [ -d $arm_path ] ; then
        mkdir $target_dir/system/app/$name/lib/arm -p
        cp $arm_path/* $target_dir/system/app/$name/lib/arm/
    fi

    if [ -d $target_dir/system/app/$name/lib/arm64 -o -d $target_dir/system/app/$name/lib/arm ] ; then
        echo '' >> $target_dir/${name,,}.mk
        echo "# $name" >> $target_dir/${name,,}.mk
        echo 'PRODUCT_COPY_FILES += \' >> $target_dir/${name,,}.mk
        app_sos=$(find $target_dir -name *.so)
        for app_so in ${app_sos[@]}; do
            echo "$name ==> $app_so"
            local so_path=${app_so:${#target_dir}+1:${#app_so}}
            echo -e "\tvendor/3rd-party/$name/$so_path:$so_path \\" >> $target_dir/${name,,}.mk
        done
    fi
}

function parse_app_permission() {
    local app_path=$1
    local name=$2
    local target_dir=$3
    local tmp_dir=/tmp/$name
    echo "$name ==> parse app permissions"

    pushd $tmp_dir > /dev/null
    $($APKTOOL d -f $name.apk)
    popd > /dev/null

    local dangeous_permissions=()
    local app_permissions=$(grep -rn "uses-permission" $tmp_dir/$name/AndroidManifest.xml | awk -F "=" '{print $NF}' | awk -F "[\"]" '{print $2}')
    for app_permission in ${app_permissions[@]}; do
        for permission in ${permissions[@]}; do
            if [ "$app_permission" = "$permission" ] ; then

                #去掉重复的权限
                local samed=1
                for d_p in ${dangeous_permissions[@]}; do
                    if [ "$d_p" = "$app_permission" ] ; then
                        samed=0
                        break;
                    fi
                done

                if [ "$samed" -eq 1 ] ;then
                    dangeous_permissions[${#dangeous_permissions[*]}]=$app_permission
                fi

                break;
            fi
        done
    done

    if [ ${#dangeous_permissions[*]} -gt 0 ] ; then
        #write permission到/system/etc/default-permissions/default-xxxxx-permissions.xml
        mkdir $target_dir/system/etc/default-permissions -p

        #获取app包名
        local manifests=$(grep -rn "<manifest" $tmp_dir/$name/AndroidManifest.xml)
        local pkg_name=""

        for manifest in ${manifests[@]}; do
            key=$(echo $manifest | awk -F "\"" '{print $1}')
            if [ "$key" = "package=" ] ; then
                pkg_name=$(echo $manifest | awk -F "\"" '{print $2}')
            fi
        done

        #echo "pkg ==>$pkg_name"

        #创建 default-xxxx-permissions.xml文件
        permission_file=$target_dir/system/etc/default-permissions/default-${name,,}-permissions.xml

        #echo "===========>$permission_file"

        echo -e "<?xml version='1.0' encoding='utf-8' standalone='yes' ?>" > $permission_file

        echo -e '
<!-- Copyright (C) 2017 The Android Open Source Project

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
-->

<exceptions>' >> $permission_file
        echo -e "    <exception package=\""$pkg_name\"">" >> $permission_file

        #<permission name="android.permission.ACCESS_COARSE_LOCATION" fixed="true" />
        for d_permission in ${dangeous_permissions[@]}; do
            #echo $d_permission
            echo -e "        <permission name=\""$d_permission\"" fixed=\""true\"" />" >> $permission_file
        done

echo -e '    </exception>
</exceptions>' >> $permission_file

        #xxxx.mk的PRODUCT_COPY_FILES添加permission文件拷贝

        local key_copy=$(cat $target_dir/${name,,}.mk | grep "PRODUCT_COPY_FILES")

        if [ -z "$key_copy" ] ; then
            echo '' >> $target_dir/${name,,}.mk
            echo "# $name" >> $target_dir/${name,,}.mk
            echo 'PRODUCT_COPY_FILES += \' >> $target_dir/${name,,}.mk
        fi

        local permission_path=${permission_file:${#target_dir}+1:${#permission_file}}

        echo -e "\tvendor/3rd-party/$name/$permission_path:$permission_path \\" >> $target_dir/${name,,}.mk

    fi

}

CURRENT=$(get_abs_path $1)

#echo $CURRENT

APKTOOL="$(cd $(dirname $0) && pwd)"/apktool

apps=$(find $CURRENT -maxdepth 1 -name *.apk)

for app in ${apps[@]}; do
    app_full_name=${app##*/}
    #echo "app_full_name" $app_full_name
    app_name=${app_full_name%.*}
    #echo "app_name "$app_name
    app_dir=$CURRENT/$app_name

    #echo "app_dir"$app_dir

    echo "$app_name ==> parse start"

    echo "$app_name ==> $app"

    if [ -d $app_dir ] ; then
        rm -rf $app_dir
    fi

    mkdir $app_dir

    #拷贝app到app目录
    cp $app $app_dir/

    create_app_mk $app_dir $app_name

    #创建Android.mk
    create_android_mk $app_dir $app_name

    tmp_dir=/tmp/$app_name

    if [ -d $tmp_dir ] ; then
        rm -rf $tmp_dir
    fi

    mkdir $tmp_dir

    #解析app
    parse_app_so $app $app_name $app_dir

    #解析permission
    parse_app_permission $app $app_name $app_dir


    #if [ -d $tmp_dir ] ; then
    #    rm -rf $tmp_dir
    #fi

    echo "$app_name ==> parse end!"

done 
