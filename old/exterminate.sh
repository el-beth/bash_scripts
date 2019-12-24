#!/bin/bash

userName=$(whoami);
programName="$1";
main(){
	pidVar=$(top -n 1 -d 1 -b | grep -i $programName | cut -c -6 );
	kill -s SIGKILL $pidVar >& /dev/null;
	echo "killed all \"$programName\" instances.";
}

if [ "$userName" == "root" ] ; then main ; else echo "run as root" ; fi;
