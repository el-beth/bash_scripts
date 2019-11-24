#!/bin/bash

## The following script will exhaustively try to find md5sum inputs which equal their output -- with the added benefit of causing the CPU to work had keeping the room warm!


current=$(head -c 32 /dev/random | md5sum - );
former="$current";

while [ 1 ];
do
	current=$(echo $current | md5sum - );
	if [ "$former" == "$current" ]
		then 
			echo "found!		$current";
			notify-send -u critical -t 99999 "Found!  $current";
			paplay /usr/lib/python2.7/dist-packages/pygame/examples/data/house_lo.ogg;
			echo $current >> "$HOME/found.txt";
			break;
		else former=$current;
			echo "$current";
	fi;
done;