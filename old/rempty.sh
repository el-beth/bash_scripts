#!/bin/bash

for input in "$@"
do
	size=$(du "$input" | cut -c -"$(numcount "$(du "$input")")");
	if [ "$size" == "0" ]
		then rm "$input" &> /dev/null;
		if [ -e "$input" ]
			then echo "couldn't remove $input";
		else echo "removed $input";
		fi
	fi
done