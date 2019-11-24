#!/bin/bash

store=endrias

while [ 1 ];
do
	store=$(echo "$store" | md5sum - );
	echo "$store";
done;