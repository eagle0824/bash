#!/bin/bash

array=(a b c d)

echo ${array[*]}
echo ${array[@]}
echo ${array}
echo ${array[2]}


array[2]=m

echo ${array[2]}
echo ${array[@]}

echo ${#array[@]}
unset array[2]
echo "unset array[2],array is ${array[@]}"
echo "unset array[2],array size is ${#array[@]}"

array=(${array[*]} h)

echo "add array data at last ,array is ${array[@]}"
array=(${array[*]:0:2} center ${array[*]:2:${#array[*]}})
echo "add center to[3],array is ${array[@]}"
unset array
echo "unset array,array size is ${#array[@]}"

function help(){
cat << HELP
	this is a help
HELP
}
