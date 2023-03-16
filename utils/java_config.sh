#!/bin/bash
if [ $# -eq 2 ]
then
    java_home=$1
    priority=$2
else
    echo "wrong params for 'param1' is java home, 'param2' is prority and must is int!"
    exit
fi

echo "java_path : " $java_home  " priority : " $priority

sudo update-alternatives --remove-all jar
sudo update-alternatives --remove-all java 
sudo update-alternatives --remove-all javac 
sudo update-alternatives --remove-all javap 
sudo update-alternatives --remove-all javadoc 

sudo update-alternatives --install /usr/bin/jar jar $java_home/bin/jar $priority 
sudo update-alternatives --install /usr/bin/java java $java_home/bin/java $priority
sudo update-alternatives --install /usr/bin/javac javac $java_home/bin/javac $priority
sudo update-alternatives --install /usr/bin/javap javap $java_home/bin/javap $priority
sudo update-alternatives --install /usr/bin/javadoc javadoc $java_home/bin/javadoc $priority
