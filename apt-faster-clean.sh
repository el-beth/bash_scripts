#!/bin/bash

if [ $(whoami) != root ]
	then echo "run as root";
	exit;
fi;

cd /var/cache/apt/archives ;
file * | grep empty | grep -oe ".*\.deb" > /tmp/apt_cleanup_tempfile.txt ;

while read trashFileName
do
	rm "$trashFileName" ;
	echo "removed $trashFileName" ;
done < /tmp/apt_cleanup_tempfile.txt;

rm /tmp/apt_cleanup_tempfile.txt;