#!/bin/bash

if [ -e lastIP.txt ]
	then
	lastIP=$(cat lastIP.txt);
else lastIP=$(curl ifconfig.co);
fi;

while [ 1 ]
do
	timeout 1m nano /dev/null;
	currentIP=$(curl ifconfig.co);
	if [ "$currentIP" != "$lastIP" ]
		then
		echo $currentIP >> ~/IPPool.txt;
	fi;
done

