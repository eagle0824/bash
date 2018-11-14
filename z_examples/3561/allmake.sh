#!/bin/sh

######## Global VARS with default value #######
IMAGES="*_Android_scatter.txt preloader_*.bin lk.bin logo.bin logo_1024x600.bin logo_800x480.bin boot.img secro.img userdata.img cache.img ramdisk.img recovery.img metazone.bin system.img bootlogo.img databak.img update.zip "
IMAGES_3561="trustzone.bin APDB_MT3561* boota64.bin ramdisk2.img kernel2.bin dtb2.bin "
IMAGES_8227="tz.img MBR EBR1 EBR2 "

RELEASE_DIR=./release_images

PLATFORM="evb3561t_66_m0"

MODULE=all

MOD=userdebug
USER_ROOT=no
CLEAN_BUILD=no
CPUS=24

PARA="release upload eng user userdebug"

######## Functions #######
### color print
function cprint() {
    while (( $# != 0 ))
    do
        case $1 in
            -B)
                echo -ne "\033[30m";
            ;;
            -r)
                echo -ne "\033[31m";
            ;;
            -g)
                echo -ne "\033[32m";
            ;;
            -y)
                echo -ne "\033[33m";
            ;;
            -b)
                echo -ne "\033[34m";
            ;;
            -p)
                echo -ne "\033[35m";
            ;;
            -c)
                echo -ne "\033[36m";
            ;;
            -w)
                echo -ne "\033[37m";
            ;;
            -h|-help|--help)
                echo "Usage: cprint -color string";
            ;;
            *)
                echo -e "$1\033[0m"
            ;;
        esac
        shift
    done
}

#### debug is printed in blue
#### information is printed in green
#### error is printed in read
function _info() {
    STR="$@"
    cprint -g "`echo $STR`"
}

function _debug() {
    STR="$@"
    cprint -b "`echo $STR`"
}

function _error() {
    STR="$@"
    cprint -r "`echo $STR`"
}

function _start_info() {
    _debug "+++++++++++++++++++++++++Build Started+++++++++++++++++++++++++++++++++"
    _info "\t\t CPUS:\t\t  "		$CPUS
    _info "\t\t PLATFORM:\t  "		$PLATFORM
    _info "\t\t MOD:\t\t  "			$MOD
    _info "\t\t MODULE:\t  "		$MODULE
    _info "\t\t USER_ROOT:\t  "		$USER_ROOT
    _info "\t\t CLEAN_BUILD:\t  "	$CLEAN_BUILD
    _info "\t\t RELEASE:\t  "		$RELEASE
    _info "\t\t UPLOAD:\t  "		$UPLOAD
    _debug "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

function _usage() {
    _error "usage: ./allmake.sh [OPTION]... [PARA]... [MODULE]"
    _error "ATC AOSP build script"
    _error "OPTION:"
    _error "\t	-c,        \t\t\tClean build."
    _error "\t	-j [N],    \t\tAllow N jobs at once."
    _error "\t	-r,        \t\t\tBuild with root permission."
    _error "\t	-p [PLAT], \t\tSpecify build which device, default is $PLATFORM."
    _error "\t	-h,        \t\t\tDisplay this help and exit."
    _error "PARA:"
    _error "\t	release,   \t\tCopy download images to $RELEASE_DIR."
    _error "\t	upload,    \t\tExchange images from RD to OA, only for ATC RD users."
    _error "\t	eng/user/userdebug, \tSpecify which Android mode."
    _error "MODULE:"
    _error "\t	all|allota."
    _error "\t	kernel|kernel2|lk|preloader|boot|system|userdata..."
    _error "\t	services.jar|backcar..."
    exit 1
}

function _para_check() {
    while getopts "cj:rp:h" opt;
    do
        case "$opt" in
        "c") CLEAN_BUILD=yes;;
        "j") CPUS=$OPTARG;;
        "r") USER_ROOT=yes;;
        "p") PLATFORM=$OPTARG;;
        "h")
            _usage
            exit 1
        ;;
        *)
            echo "Unknown option";
            exit 1
        ;;
        esac
    done

    shift $(($OPTIND-1))
    args=$#
    lastarg=${!args}

    #Check the last para is in $PARA or not?
    #If in, the MODULE is not valid
    #If not, the MODULE is valid
    if [ $args -ne 0 ]; then
        if [ -z "`echo $PARA | grep -w $lastarg`" ]; then
            MODULE="$lastarg"
        fi

        if [ ! -z "`echo $@ | grep -w release`" ]; then
            RELEASE=release
        fi

        if [ ! -z "`echo $@ | grep -w upload`" ]; then
            UPLOAD=upload
        fi

        if [ ! -z "`echo $@ | grep -w eng`" ]; then
            MOD=eng
        elif [ ! -z "`echo $@ | grep -w user`" ]; then
            MOD=user
        fi
    fi

    _start_info
}

function _setup() {
    _debug "$FUNCNAME START `date`"
    source ./build/envsetup.sh
    lunch full_$PLATFORM-$MOD
    _debug "$FUNCNAME END `date`"
}

function _option() {

    _debug "$FUNCNAME START `date`"

    if [ x"$CLEAN_BUILD" = x"yes" ]; then
        mv out out_bk
        rm -rf out_bk &
    fi

    if [ x"$MODE" = x"user" -a x"$USER_ROOT" = x"yes" ]; then
        _debug "+++++++++ USER BUILD WITH ROOT ++++++++++++"
        MTK_BUILD_ROOT="yes"
    fi

    case $MODULE in
        #### Here are some convenience cmd.
        kernel)    CMDLINE="mmm $FORCE kernel-3.18:kernel";;
        kernel2)   CMDLINE="mmm $FORCE arm2/kernel2/kernel-3.18:kernel2";;
        preloader) CMDLINE="mmm $FORCE vendor/mediatek/proprietary/bootable/bootloader/preloader:pl";;
        lk)        CMDLINE="mmm $FORCE vendor/mediatek/proprietary/bootable/bootloader/lk:lk";;
        *)
            if [ -z $MODULE ] || [ $MODULE == "all" ]; then
                _debug "###########make update-api and make all############"
                CMDLINE="make upate-api;make"
            elif [ $MODULE == "allota" ]; then
                _debug "###########make update-api and make allota#########"
                CMDLINE="make update-api;make droid otapackage"
            elif [ $MODULE == "inc-ota" ]; then
                _debug "###########make inc-ota########"
                CMDLINE="make inc-otapackage"
            else
                _debug "###########make $MODULE########"
                CMDLINE="make $MODULE"
            fi
        ;;
    esac

    eval "$SERVER MTK_BUILD_ROOT=$MTK_BUILD_ROOT $CMDLINE -j$CPUS"
    if [ "$?" -ne 0 ]; then
        _error "failed to execute $CMDLINE"
        exit 1
    fi

    _debug "$FUNCNAME END `date`"
}

function _release() {
    _debug "$FUNCNAME $# $@ START `date`"

    if [ ! -d out/target/product/$PLATFORM ]; then
        _error "Images not exist, build it?"
        #TODO: maybe user want build
        exit 1
    fi

    rm -rf $RELEASE_DIR
    mkdir -p $RELEASE_DIR

    #3561 meta
    cp out/target/product/$PLATFORM/obj/CGEN/APDB_* out/target/product/$PLATFORM

    #Newest ota zip
    ota_zip=`ls -t out/target/product/$PLATFORM/${TARGET_PRODUCT}-ota-* 2>/dev/null | head -1 | xargs basename 2>/dev/null`
    if [ "x$ota_zip" != "x" ]; then
        IMAGES="$IMAGES $ota_zip"
    fi
    
    lzma -k out/target/product/$PLATFORM/obj/KERNEL_OBJ/vmlinux
    cp out/target/product/$PLATFORM/obj/KERNEL_OBJ/vmlinux.lzma $RELEASE_DIR

    #modem DB.
    if [ -d out/target/product/$PLATFORM/system/etc/mddb ]; then
        cp out/target/product/$PLATFORM/system/etc/mddb/BPMdMetaDatabase* $RELEASE_DIR
    fi

    #TODO: Distinguish different ICs
    _info "$IMAGES $IMAGES_3561 "
    for FILE in $IMAGES $IMAGES_3561
    do
        cp out/target/product/$PLATFORM/$FILE $RELEASE_DIR
    done

    _debug "$FUNCNAME END `date`"
}

function _upload() {
    _debug "$FUNCNAME START `date`"
    if [ ! -d $RELEASE_DIR ]; then
        _error "$RELEASE_DIR not exist, copy now"
        _release
    fi

    if [ ! -z $RELEASE ]; then
        _release
    fi

    mtkbuild -d -o $RELEASE_DIR

    _debug "$FUNCNAME END `date`"
}

function _build() {
    _info "$FUNCNAME START `date`"

    if [ ! -z $UPLOAD ]; then
        _upload
    elif [ ! -z $RELEASE ]; then
        _release
    else
        _setup
        _option
        _release
        ##_upload
    fi

    _info "$FUNCNAME END `date`"
}

function _main() {
    _para_check "$@"

    _build 2>&1 | tee build_$PLATFORM.log
    ret=${PIPESTATUS[0]}
    if [ ! $ret  = 0  ]; then
        exit $ret
    fi
}

######## Main Entry #######
_main "$@"
