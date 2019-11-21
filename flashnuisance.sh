#!/bin/bash

location=$(lsblk | grep part | grep -v sda | cut --complement -c -36)
device=$(lsblk | grep disk | grep -v sda | cut -c -3)
rm $location/*.pif $location/*.inf $location/*.exe >& /dev/null
echo "done cleaning " /dev/$device "mounted on" $location 
