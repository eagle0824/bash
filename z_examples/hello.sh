#!/bin/bash

if [ $SHELL = "/bin/bash" ] 
	then echo used bin bash!
else
	echo not used bin bash!	
fi

if [ -f "./test" ]; then echo test is file!

else echo test is not file! 

fi 

[ -f "/bin/bash" ] && echo bash file is exist!
[ -x "/bin/bash" ] && echo bash file can run!
[ -n "$var" ] && echo var not null

#bash_path=/bin/path
#if [ -x "$bash_path"  -r "$bash_path" ]; then echo bash can execute and read!
#else
#	echo bash can not execute or read!	
#
#fi


for var in 1 2 3 4 5 6 7 
	do
		echo "var is" $var	
	done	

x=10
let "x=$x + 1"
let "x+=1"
x=$[$x+1]
echo num is ${x}end

x=`expr $x + 1`
echo num is $x
