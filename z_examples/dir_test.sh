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

declare -a data

function print_blank()
{
    #params 
    #    1 name 
    #    2 level min is 0 
    #    3 index min is 0
    #    4 count min is 1
    #    5-$# level

    echo $*
    data_len=`expr $# - 4`
    display_data=($*)
    display_data=(${display_data[*]:4:$data_len})
    echo ${display_data[*]}
    for i in $(seq $2)
    do
        case $i in
            1)
                if [ $2 -eq $4 -a $2 -eq 2 ]
                then
                    printf "    "
                else
                    printf "│   "
                fi
                ;;
            $2)
                if [  $3 -eq  `expr $4 - 1` ]
                then
                    printf "└── "
                else
                    printf "├── "
                fi
                ;;
            *)
                printf "    "
                ;;
        esac
    done
    printf $1"\n"
}

#function print_blank()
#{
#    #params 
#    #    1 name 
#    #    2 level min is 0 
#    #    3 index min is 0
#    #    4 count min is 1
#    #    5-$@ level
#
#    echo $*
#    data_len=`expr $# - 4 `
#    if [ $2 -eq 1 ]
#    then
#        if [  $3 -eq  `expr $4 - 1` ]
#        then
#            printf "└── "
#        else
#            printf "├── "
#        fi
#    else
#        echo $(seq $2)
#        for i in $(seq $2)
#        do
#            case $i in
#                1)
#                    if [ $2 -eq $4 -a $2 -eq 2 ]
#                    then
#                        printf "    "
#                    else
#                        printf "│   "
#                    fi
#                    ;;
#                $2)
#                    if [  $3 -eq  `expr $4 - 1` ]
#                    then
#                        printf "└── "
#                    else
#                        printf "├── "
#                    fi
#                    ;;
##                `expr $2 - 1`)
##                    if [  $3 -eq  `expr $4 - 1` ]
##                    then
##                        printf "│   "
##                    else
##                        printf "│   "
##                    fi
##                    ;;
#                *)
#                    printf "    "
#                    ;;
#            esac
#        done
#    fi
#    printf $1"\n"
#}
function show_dir()
{
    level=$2
    #echo "show dir $*"
    if [ -d "$1" ]
    then
        list=`ls $1`
        array=($list)
        count=${#array[@]}
        index=0
        level=`expr $level + 1`
        display=(${display[*]} $level)
        for name in $list
        do 
            file=$1/$name
            print_blank $name $level $index $count ${display[*]}
            if [ -d $file ]
            then
                show_dir $file $level $index $count ${display[*]}
            fi
            index=`expr $index + 1`
        done
        level=`expr $level - 1`
        len=`expr ${#display[@]} - 1`
        if [ $len -ne 0 ]
        then
            display=(${display[@]:0:len})
        fi
        index=$3
        count=$4
    else #top level is file
        echo "file ===============================>"
        print_blank $name $level $index $count ${display[*]}
    fi
}






echo "args $*"

path=$(get_abs_path $1)

echo $path

show_dir $path 0 
