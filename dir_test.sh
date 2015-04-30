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


function show_dir()
{
    level=$2
    echo "show dir $*"
    if [ -d "$1" ]
    then
        list=`ls $1`
        array=($list)
        count=${#array[@]}
        index=0
        for name in $list
        do 
            file=$1/$name
            if [ -d $file ]
            then
                print_blank $name $level $index $count
                disply=($disply $level)
                level=`expr $level + 1`
                echo "disply start =================================> ${disply[*]}"
                show_dir $file $level $index $count
                len=`expr ${#disply[@]} - 1`
                disply=${disply[@]:0:len}
                echo "disply end =================================> ${disply[*]}"
                level=`expr $level - 1`
                
            else
                print_blank $name $level $index $count
            fi
            index=`expr $index + 1`
        done
        index=$3
        count=$4
    else 
        print_blank $1 $level $index $count
        index=`expr $index + 1`
    fi
}

function print_blank()
{

    #params 
    #    1 name 
    #    2 level min is 1 
    #    3 index min is 0
    #    4 count min is 1

    #echo $*
    if [ $2 -eq 1 ]
    then
        if [  $3 -eq  `expr $4 - 1` ]
        then
            printf "└── "
        else
            printf "├── "
        fi
    else
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
#                `expr $2 - 1`)
#                    if [  $3 -eq  `expr $4 - 1` ]
#                    then
#                        printf "│   "
#                    else
#                        printf "│   "
#                    fi
#                    ;;
                *)
                    printf "    "
                    ;;
            esac
        done
    fi
    printf $1"\n"
}




echo "args $*"

path=$(get_abs_path $1)

echo $path

show_dir $path 1
