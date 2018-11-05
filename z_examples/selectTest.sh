#!/bin/bash

echo "What is your favourites os?"
select var in "Linux" "Gun Hurd" "Free BSD" "Other"
do
	break;
done;
echo "You have selected $var"
