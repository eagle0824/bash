#!/bin/bash

# . gitclone.sh name1 name2 name3 ...
# . gitclone.sh rm curent apps and re-clone from server
function clone_code
{
    for var in $*;do
        if [ $var != "gitclone.sh" ] ; then
            echo $var
            if [ -d $var ] 
            then
                rm $var -rf 
            fi
            git clone gitolite@192.168.1.150:rkpx2/platform/packages/apps/$var -b clwbase 
        fi
    done
}

echo params : $*

if [ $# -eq 0 ] ; then
    ls -l | awk 'NR > 1 { print $9 }'| while read line
    do
        clone_code $line
    done
else
    clone_code $*
fi
