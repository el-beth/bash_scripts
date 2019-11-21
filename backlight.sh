#!/bin/bash

BRIGHTNESS_DIRECTORY=$(cd /sys/class/backlight/* && pwd);
BRIGHTNESS_FILE="$BRIGHTNESS_DIRECTORY/brightness";
MAX_BRIGHTNESS_FILE="$BRIGHTNESS_DIRECTORY/max_brightness";
MAX_BRIGHTNESS=$(cat $MAX_BRIGHTNESS_FILE);
USERNAME=$(whoami)

checkUser(){
	if [ $USERNAME != "root" ];
		then printf "\nrun this script as root\n" && exit;
		fi;
}

error_report(){
	printf "error: the backlight brightness value $1 is out of range, use only [0,$MAX_BRIGHTNESS]\n";
}

checkUser;

if [ $1 -ge 0 ] &&  [ $1 -le $MAX_BRIGHTNESS ] &> /dev/null;
then echo $1 > "$BRIGHTNESS_FILE";
else error_report;
fi;


## FINISHED
