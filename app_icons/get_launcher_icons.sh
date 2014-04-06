#!/bin/bash

ANDROID_MANIFEST=AndroidManifest.xml 
ICON_ATTRIBUTE=android:icon 
ICON_SUFIX=.png
COPY_ICON_DIR=data

function help()
{
echo '

    command :

            ./get_icon_format_name.sh code_path [icon_type] [s]
 

    params  :

        code_path   : which is the path of app
           
        icon_type   : which value is hdpi,xhdpi,ldpi,nodpi,sw600dp-w1024dp-mdpi and so on.
                    it is not necessary! if is null it stand for drawable or mipmap dir
                    if icon_type is "all",just read icon from androidManifest.xml

        s           : is cmd which value is "s",which is meaning if need to add ".png" to the name of icon.

    note    : if icon_type is not "all"  ./data is the app icon on lancher named appname_icon

'
}

function get_code_path()
{ 
    if [ "$code_path" = "." -o "$code_path" = "./" ]
    then
        /bin/pwd
    else
        cd $code_path
        /bin/pwd
        cd - > /dev/null
    fi
}

function get_current_path()
{
    /bin/pwd
}

#echo "shell start"

code_path=
type=
sufix=

if [ $# -lt 1 -o $# -gt 3 ] 
then
    echo '
    wrong params!'
    help
else
    code_path=$1
    if [ "$2" != "" ]
    then
        if [ "$2" != "s" ]
        then
            type=$2 
        else
            sufix=$2
        fi
    fi

    if [ "$3" != "" -a "$3" = "s" ]
    then
        sufix=$3
    fi

#echo 'code_path : '$code_path
#echo 'type : '$type
#echo 'sufix : '$sufix
    
    code_path=$(get_code_path)
#echo 'code_path : '$code_path
    
    dir_path=$(get_current_path)/$COPY_ICON_DIR
#echo $dir_path
    
    if [ -d "$dir_path" ]
    then
        rm -rf $dir_path
        mkdir $dir_path
    else
        mkdir $dir_path
    fi
    
    files=$(find $code_path -name $ANDROID_MANIFEST)
    for file in $files
    do
#echo $ANDROID_MANIFEST 'path :' $file
        app_path=$(dirname $file);
#echo $ANDROID_MANIFEST 'dir path :' $app_path
        app_name=$(basename $app_path)
#echo 'app name :' $app_name

        if [ "$app_name" = "tests" -o "$app_name" = "test" ]
        then
            continue
        elif [ "$app_name" = "bin" -o "$app_name" = "main" ]
        then
            continue
        fi

        res_dir=$app_path'/res'
#echo 'res dir :' $res_dir
        drawable_attrs=$(grep -r $ICON_ATTRIBUTE $file)

#echo $drawable_attrs
        tmp=
        for var in $drawable_attrs
        do
            if [ "`echo $var|grep -c $ICON_ATTRIBUTE`" != "0" ]
            then
                icon_name=${var#$ICON_ATTRIBUTE*\@}
                icon_dir=${icon_name%%\/*}
#echo 'icon dir :' $icon_dir
                icon_name=${icon_name#*\/}
                icon_name=${icon_name%\"*}

                if [ "$tmp" != ""  -a "$tmp" = "$icon_dir$icon_name" ]
                then
                    continue
                else
                    tmp=$icon_dir$icon_name
                fi

                icon_full_name=$icon_name$ICON_SUFIX
#echo 'icon_name :' $icon_name
#echo 'icon_full_name :' $icon_full_name
                if [ "$sufix" != "" -a "$sufix" = "s" ]
                then
                    icon_name=$app_name'_'$icon_name$ICON_SUFIX
                else
                    icon_name=$app_name'_'$icon_name
                fi
                if [ "$type" != "" ]
                then
                    if [ "$type" = "all" ]
                    then
                        echo $icon_name
                        continue;
                    fi
                    icon_dir=$icon_dir"-"$type
                fi
                drawable_dir=$res_dir'/'$icon_dir
#echo 'icon dir :' $drawable_dir
                if [ -d "$drawable_dir" ]
                then
                    drawable=$(find $drawable_dir -name $icon_full_name)
                    if [ "$drawable" != "" ]
                    then
                        cp $drawable $COPY_ICON_DIR'/'$app_name'_'$icon_full_name
                        echo $icon_name
                    fi
                fi
            fi
       done
    
    done #done for file

fi

#echo "shell end"
