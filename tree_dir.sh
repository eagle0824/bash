#!/bin/bash

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

# error when dirA/dirA
#function get_abs_path()
#{
#    if [ -z $1 ]
#    then
#        realpath .
#    else
#        realpath -s $1
#    fi
#}

function print_blank()
{

    #params 
    #    1 name 
    #    2 level min is 1 
    for i in $(seq $2)
    do
        case $i in
            1)
                printf "    "
                ;;
            $2)
                printf "    "
                ;;
            *)
                printf "    "
                ;;
        esac
    done
    printf $1"\n"
}

function show_dir()
{
    level=$2
    #echo "show dir $*"
    level=`expr $level + 1`
    if [ -d "$1" ]
    then
        for name in `ls $1` 
        do 
            file=$1/$name
            if [ -d $file ]
            then
                print_blank $name $level
                show_dir $file $level
            else
                print_blank $name $level
            fi
        done
    else 
        print_blank $1 $level
    fi
    level=`expr $level - 1`
}



echo "args $*"

path=$(get_abs_path $1)

echo $path

show_dir $path 0 
