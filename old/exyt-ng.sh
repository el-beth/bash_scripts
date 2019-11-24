#!/bin/bash

wlaniface=$(iwconfig | grep 802.11 | cut -c -6 );
moniface=$(iwconfig | grep Monitor | cut -c -6 );
dumpdir="/var/cache/monitor-ng"

kill $(top -n 1 -d 1 -b | grep airodump-ng | cut -c -5 ) &> /dev/null;
kill $(top -n 1 -d 1 -b | grep aireplay-ng | cut -c -5 ) &> /dev/null;

ifconfig $moniface down &> /dev/null;
iwconfig $moniface mode managed &> /dev/null;
ifconfig $moniface up &> /dev/null;

service network-manager restart &> /dev/null; 
service avahi-daemon restart &> /dev/null;
service wpa-supplicant restart &> /dev/null;

sudo rm -r "$dumpdir";

echo "your system has been reset to the initial config";
