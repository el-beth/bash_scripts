#!/bin/bash

todayDate=$(date | grep -oe "[A-Za-z]\{3\}\ [0-9]\{1,2\}\ [A-Za-z]\{3\}");
userName=$(whoami)

if [ "$userName" == "root" ]
	then echo "run this script only as not-root"
else if [ ! -d "$todayDate" ]
	then mkdir "$HOME/Desktop/surfDump/$todayDate" &> /dev/null;
	fi;
fi;



