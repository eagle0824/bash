#! /bin/bash

scriptFile=runsed.sh
sedFile=sed.sh
tmpFile=tmp$$

if [ $# -eq 0 ] ;then
	echo "edit file is null!"
fi

for x in $@
do
	echo "editing file $x"
	if [ $x == $scriptFile ] ; then
		echo "can't editing $scriptFile!"
		return	
	elif [ -s $x ] ; then
		sed -f $sedFile $x > /tmp/$tmpFile
		#sed -f $sedFile $x 
		#return
		if [ -s /tmp/$tmpFile ] ; then
			if cmp -s $x /tmp/$tmpFile
			then
				echo "file $x not changed!"
			else
#				mv $x $x.bak # copy $x to $x.bak
				cp /tmp/$tmpFile $x
			fi
		else
			echo "sed produced an empty file!"
			echo "please check your sedscript file $sedFile!"
		fi
		rm -r /tmp/$tmpFile
	else
		echo "original file $x not exit or file is empty!"
	fi

done
echo "all done!"
