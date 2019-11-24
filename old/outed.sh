#!/bin/bash

## prepare for monitoring

rfkill unblock all &> /dev/null;
service network-manager stop &> /dev/null;
service avahi-daemon stop &> /dev/null;
service wpa_supplicant stop &> /dev/null;
ifconfig wlp3s0 down &> /dev/null;
iwconfig wlp3s0 mode mon &> /dev/null;
ifconfig wlp3s0 up &> /dev/null;

## ready for monitoring

## make write directory ready 

currentNumber=0;
dumpDirectory="$HOME/Desktop/code2018/network/homePacketCaptures"

while [ -d "$dumpDirectory/$currentNumber" ];
do
	currentNumber=$(incr $currentNumber);
done;

## redundant check of dump directory for current session

if [ ! -d "$dumpDirectory/$currentNumber" ];
	then mkdir "$dumpDirectory/$currentNumber";
	currentDir="$dumpDirectory/$currentNumber";
fi;

## dumping

airodump-ng -w "$dumpDirectory/$currentNumber/dump" wlp3s0;
