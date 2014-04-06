#!/bin/bash

android_manifest="AndroidManifest.xml"

function help()
{
echo '

    command :
    
        ./replace_icon.sh icons_path code_path [icon_type] [c]
    
    params :
     
          icons_path  : the dir of new icon 
                            the name of icon format is appname_iconname.png.
                            app name is the dir name of the apk for example Settings,
                            iconname is defined in AndroidManifest.xml android:icon="@*/iconname" for example ic_launcher_settings
    
          code_path   : the dir of apps
    
          icon_type   : which value is hdpi,xhdpi,ldpi,nodpi,sw600dp-w1024dp-mdpi and so on.
                            it is not necessary! if is null it stand for drawable or mipmap dir
    
          c           : is cmd which value is "c",which is meaning if need to create new icon,if not find icon in icon_path dir.
                            it is not necessary! if is null it stand for not careate icon when icon not exist!
    
    
     example 1: only replace old icons with new icons
                ./replace_icon.sh ./icons ./build/android/packages/app/ xhdpi
    
     example 2: replace old icons with new icons and create new icon and dir if old the dir of icon not exit!
                ./replace_icon.sh ./icons ./build/android/packages/app/ xhdpi c
 

'
}

function get_icons_path()
{ 
    if [ "$icons_path" != "./" -a "$icons_path" != "." ]
    then
        cd $icons_path
        /bin/pwd
        cd - > /dev/null
    else
        /bin/pwd
    fi
} 

function get_code_path()
{ 

    if [ "$code_path" != "./" -a "$code_path" != "." ]
    then
        cd $code_path
        /bin/pwd
        cd - > /dev/null
    else
        /bin/pwd
    fi
}

#echo $1
#echo $2

if [ $# -ge 2 ]
then
    icons_path=$1
    icons_path=$(get_icons_path)

#    echo "icon_path : " $icons_path

    code_path=$2
    code_path=$(get_code_path)

#    echo "code_path : " $code_path

    if [ "$3" != "" -a "$3" != "c" ]
    then 
        type=$3
    fi
#    echo "icon type : " $type

    icons=$(find $icons_path -name *.png)
    for icon in $icons
    do
        icon_full_name=$(basename $icon)
#        echo $icon_full_name
        app_name=${icon_full_name%%\_*}
#        echo $app_name
        icon_name=${icon_full_name#$app_name"_"}
#        echo $icon_name

        paths=$(find $code_path -type d -name $app_name)        

        if [ "$paths" = "" ]
        then
            paths=$(basename $code_path)
            if [ "$paths" == "$app_name" ]
            then
                paths=$code_path
            else
                continue
            fi
        fi

#        echo $app_path
        tmp_icon_name=${icon_name%%\.png}
#        echo $tmp_icon_name
        app_path=${paths[0]}
#        echo "app_path : "$app_path

        if [ ! -d $app_path ]
        then
            echo $app_path "dir not exist!"
            continue
        fi

        manifest_file_path=$app_path'/'$android_manifest

        if [ ! -f $manifest_file_path ]
        then
            echo $manifest_file_path "file not exist!"
            continue
        fi

        str=$(grep -r $tmp_icon_name $manifest_file_path)

#        echo ${str[0]}
        tmp_prefix_path=${str%%\/$tmp_icon_name*}
#        echo $tmp_prefix_path

        icon_type=${tmp_prefix_path##*\"@}
#        echo "read file icon type from AndroidManifest.xml is $icon_type"

        app_icons=$(find $app_path -name $icon_name)
        for app_icon in $app_icons
        do
#            echo $app_icon
            app_icon_dir=${app_icon%%\/$icon_name}
            app_icon_dir=${app_icon_dir##*\/}
            #echo $app_icon_dir
            if [ "$type"!="" ]
            then
                tmp_dir=$icon_type"-"$type
            else
                tmp_dir=$icon_type
            fi

#            echo $app_icon_dir
#            echo $tmp_dir
            if [ "$app_icon_dir" != "" -a "$tmp_dir" == "$app_icon_dir" ]
            then 
#                echo $app_icon
#                echo $icon
                echo "note : cp $icon_name to $app_icon"
                cp $icon $app_icon
            fi
        done
        
        if [ "$type" != "" ]
        then
            new_icon_path=$app_path/res/$icon_type-$type 
        else
            new_icon_path=$app_path/res/$icon_type 
        fi
        #echo $new_icon_path
        if [ -e $new_icon_path'/'$icon_name ]
        then
            echo "$icon_full_name copy successfully!!!"
        else
            if [ "$#" -eq "4" -a "$4" = "c" ]
            then
                echo "icon dir : "$new_icon_path
                if [ -d $new_icon_path ]
                then
                    cp $icon $new_icon_path'/'$icon_name
                    echo "$icon_full_name file create successfully!!!"
                else
                    echo "note : dir not exist and mkdir $new_icon_path"
                    mkdir $new_icon_path
                    cp $icon $new_icon_path'/'$icon_name
                    echo "$icon_full_name file create successfully!!!"
                fi
            elif [ "$#" -eq "3" -a "$3" = "c" ]
            then
                if [ -d $new_icon_path ]
                then
                    cp $icon $new_icon_path'/'$icon_name
                    echo "$icon_full_name file create successfully!!!"
                else
                    echo "note : dir not exist and mkdir $new_icon_path"
                    mkdir $new_icon_path
                    cp $icon $new_icon_path'/'$icon_name
                    echo "$icon_full_name file create successfully!!!"
                fi
            else
                echo "warring file not copy successfully because of no dir,you can add params c to force careate dir!"
            fi
            
        fi

    done

else
    echo '
    wrong params!'
    help
fi


#echo "end......"
