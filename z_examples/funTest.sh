#!/bin/bash

function help(){
cat <<HELP
	This is a generic command line parser demo.
	USAGE EXAMPLE:funTest -l hello -f -- -somefile1 somefile2
HELP
exit 0
}
echo $(expr 3 \<= 4)
$(shell expr $$(echo $(MAKE_VERSION) | sed "s/[^0-9\.].*//") \>= 3.81)
eq=$(expr $(echo "MAKE_VERSION is 3.81" | sed 's/[^0-9\.]*//') \<= 3.81)

echo "eq $eq"

while [ -n "$1" ]; do
	case "$1" in
	-h) help;shift 1;;#function help is called
	-f) opt_f=1;shift 1;;
	-l) opt_l=$2;shift 2;;
	--) shift;break;;
	-*) echo "error: no such option $1 -h for help" ; exit 1;;
	*)break;;
	esac
done

echo "opt_f is $opt_f"
echo "opt_l is $opt_l"
echo "first arg is $1"
echo "2nd arg is $2"


pwd= /bin/pwd

echo "pwd : $pwd"
function test_params(){
	echo '$* : '"$*"
	echo '$@ : '"$@"
	echo '$# : '"$#"
	echo '$1 : '$1
	echo '$0 : '$0
	echo '$$ : '$$
	echo '$! : '$!
	echo '$_ : '$_
	echo '$- : '$-
	echo '$? : '$?
	path=23
	return $path
}
test_params 112 12 12 31 12 21
echo '$? : '$?

function test_return(){
	echo "hello"
}

#echo $(test_return)
