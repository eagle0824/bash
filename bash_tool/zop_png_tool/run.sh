#! /bin/bash

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

CURRENT=$(get_abs_path $1)

#echo $CURRENT

ZOPTOOL="$(cd $(dirname $0) && pwd)"/zopflipng

pngs=$(find $CURRENT -name "*.png")

for png in ${pngs[@]}; do

    #echo "${png}"

    suffix=${png: -6}
    if [ $suffix = ".9.png" ]
    then
        echo "ignore ==> ${png}"
    else
        $ZOPTOOL -m ${png} ${png}.new && mv -f ${png}.new ${png}
    fi
done 
