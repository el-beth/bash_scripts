#!/bin/bash

wlaniface=$(iwconfig | grep 802.11 | cut -c -6 );
moniface=$(iwconfig | grep Monitor | cut -c -6);
dumpdir="/var/cache/monitor-ng";
essid=$1;
myBSSID=$2;

kill $(top -n 1 -d 1 -b | grep airodump-ng | cut -c -5 ) &> /dev/null;
cd "$dumpdir";
apBSSID=$(cat "$dumpdir"/capture-01.csv | grep -m 1 "$essid" | cut -c -17);
cat "$dumpdir"/capture-01.csv | grep "$apBSSID" | cut -c -17 | grep -v "$apBSSID" | grep -v "$myBSSID" > "$dumpdir"/assocSSID.macs;