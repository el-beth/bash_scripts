#!/bin/bash

## script by elbeth [ Endrias Argaw Damtie ]

targetAddress="8.8.8.8"

notify() {
	notify-send -u critical Network "Internet connectivity available";
	paplay /usr/share/sounds/ubuntu/ringtones/Bliss.ogg;
	exit;
}

pingcheckwrapee() {
	while [ 1 ];
	do
		packetLoss=$(ping -w 1 $targetAddress | grep -o -e "[0-9]\{1,3\}% packet loss" | grep -o -e "^[0-9]\{1,3\}");

		if [ $packetLoss -eq 0 ]; 
			then notify;
		fi;
	done;
}

main() {
	pingcheckwrapee >& /dev/null;
}

main;