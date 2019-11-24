#!/bin/bash

## E.A.Damtie
## count from 1 to the argument number if calling argument is not a number will print "wrong input";

loopCounter=1;

if [ $(isnumber "$1") == "true" ]
	then
		while [ $loopCounter -le $1 ]; do echo $loopCounter ; loopCounter=$(incr $loopCounter); done;
	else echo "wrong input";
fi

