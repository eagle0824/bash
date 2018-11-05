#!/bin/bash

function clone_code
{
    for var in $*;do
        if [ $var != "git_update.sh" -a $var != "gitolite-admin" ] ; then
            echo $var
            cd $var && git pull && cd - >/dev/null
        fi
    done
}

#echo params : $*

if [ $# -eq 0 ] ; then
    ls -l | awk 'NR > 1 { print $9 }'| while read line
    do
        clone_code $line
    done
else
    clone_code $*
fi
