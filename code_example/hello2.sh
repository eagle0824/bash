#!/bin/bash

STR="Hello World!"
echo STR

x=10
let "x = $x +2"
echo x is $x
for var in one two three four five
	do
		let "x = $x +2"
		echo var is $var and x is $x
	done

x="olympic'"$x 
echo $x


echo "please input number"

for num 
	do
	echo "num is " $num 
	done
