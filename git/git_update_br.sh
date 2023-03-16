#!/bin/bash

function help(){
    
echo '

    command : ./git_update_br.sh all_apps_dir branch_name [cmd]

        all_app_dir : is all apps dir,for example "/work/build/package/apps"
        branch_name : is which branch you will checkout,for example "master"
        cmd         : which is u meaning update branch_name

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

function check_branch 
{
    for var in $*;do
        echo $var
        if [ $var != "gitclone.sh" ] ; then
            app_path=$abs_path'/'$var
            if [ -d $app_path ]
            then
                if [ "$cmd" != "" -a "$cmd" == "u" ]
                then
                    cd $app_path && git checkout $branch_name && git pull && cd - >/dev/null
                    echo ""
                else
                    cd $app_path && git checkout $branch_name && cd - >/dev/null
                    echo ""
                fi
            fi
        fi
    done
}

if [ "$1" == "" -o "$2" == "" ]
then
    help 
    exit 0
fi

code_path=$1
echo $code_path
branch_name=$2
echo $branch_name
cmd=$3
echo $cmd

if [ "$code_path" == "./" ] ; then
#    echo $#
    check_branch $*
else
#    echo $#
    abs_path=$(get_code_path)
    #echo $abs_path
    current_path=$(/bin/pwd)
    #echo $current_path
    cd $code_path
    ls -l | awk 'NR > 1 { print $9 }'| while read line
    do
        check_branch $line
    done
    cd $current_path 
fi
