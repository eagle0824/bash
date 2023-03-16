#!/bin/bash

function help()
{
echo '
    command :
            ./pngcrush_script.sh srcdir tardir
    params  :
        srcdir: which is the path of source pngs
        tardir: which is the path of out pngs
'
}

if [ $# != 2 ] 
then
    echo '
    wrong params!'
    help
else 
    srcdir=$1
    srcdir=${srcdir%*/}
    tardir=$2
    if [ ! -d $tardir ]
    then
        echo "mkdir $tardir"
        mkdir -p "$tardir"
    fi

    #echo srcdir $srcdir tardir $tardir

    files=$(find ${srcdir} -name *.png)

    for png in $files;
    do
        name=$(basename ${png})
        path_name=${png#*${srcdir}/}
        echo "path=========>$path_name name $name" 

        if [ ${name} != ${path_name} ]
        then
            dir_name=${path_name%*${name}}
            #dir_name=${dir_name#*/}
            target_dir_name=${tardir}/${dir_name}
            if [ ! -d ${target_dir_name} ]
            then
                echo "mkdir out dir path ${target_dir_name}" 
                mkdir -p ${target_dir_name}
            fi
        fi
        pngcrush -reduce -brute "$png" "$tardir/${path_name}"
    done;

    source_dir_size=$(du -sh ${srcdir})
    target_dir_size=$(du -sh ${tardir})
    echo "source dir size:" $source_dir_size", target dir size :" $target_dir_size
fi
