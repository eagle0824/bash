#!bin/bash

# . gitclone.sh name1 name2 name3 ...
# . gitclone.sh rm curent apps and re-clone from server
function clone_code
{
    for var in $*;do
        echo $var
        if [ $var != "gitclone.sh" ] ; then
            rm $var -rf && git clone gitolite@192.168.1.150:wincalcd/code/packages/apps/$var -b wincalcd
        fi
    done
}


#function add_app
#{
#    local app=$1
#    apps=(${apps[@]} $app) 
#}

if [ $# -eq 0 ] ; then
    echo $#
    ls -l | awk 'NR > 1 { print $9 }'| while read line
    do
        clone_code $line
    done
else
    echo $#
    clone_code $*
fi
