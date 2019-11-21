#!/bin/bash
# Endrias A. D. 


#v0.1 notes

## CALL THIS SCRIPT WITH A PROPERLY FORMATTED WILDCARD EXPRESSION - I.E. CORRECTLY SKIPPED WHITESPACE CHARACTERS OR THE POSSIBILITY OF SUCH CHARACTERS IN THE ARGUMENT LIST PREMPTED BY USE OF A PAIR OF QUOTATION MARKS, AND THE REDUNDANT ENTRIES IN THE LIST WILL BE MOVED TO A DIRECTORY CALLED 'del' IN THE PRESENT WORKING DIRECTORY.
## THIS SCRIPT USES md5sum AND TO MAKE THINGS SIMPLE NO COUNTER MEASURES AGAINST CALLING THE SCRIPT WITH A DIRECTORY NAME HAVE BEEN EMPLOYED, SO TO WORK ON A DIRECTORY unredund.sh <directory_name>/*
## IF A BETTER DIGEST ALGO IS KNOWN ABOUT REPLACE THE md5sum AND THE LENGTH OF THE cut FROM -32 HERE TO THE OUTPUT LENGTH OF THE REPLACEMENT PROGRAM.


### v1.1 changelogs
## the script now accepts calling with directory names. The execution is a conditional recursive call being made to the same script, but instead of passing the same calling argument, this version calls the script with the calling argument's path- which is the path to a directory will now have a /* appended to conform with the formal functioning of the script.

## N.B. the "head" and "less" programs used for reading only the begining and end of the file make the overall oeration of the script slower. as such this version will only be a finctionally better script for files which are large in size but for smaller files the earlier version will be better.
## to circumvent the previously mentioned caveat, the method that uses the head and less will only be employed when the file is more than 50M( here the unix convention of refering to base 2 exponents as K,M,G instead of their equivalents Ki,Mi,Gi are used) = 50*1024*2014 = 52,428,800bytes ->> this is an arbitrary value, future actual performance metrics will be employed to decide a rational value.

## upon measurement of the time lapsed during running the script on a redundant 1.9G file, the one that hashes the whole file did it in 1.94 seconds while the one adapted for larger files did so in 1.65 seconds - measured by appending and prepending the date command i.e.  "date -I'ns' && HASHINGMETHOD && date -I'ns'" replacing HASHINGMETHOD with each of the two hashing methods . // There might be greater difference between the two if the script is employed on a storage media that will allow faster reading and seeking - like a quick SSD, in which case the slowest, speed determining step will be the computation of the hashes as opposed to the reading and seeking of the file on the HDD - which is evidently the slowest step on systems which use HDD for secondary storage.

## v.1.2 plans
## overall process can be sped up by replacing the md5sum by a faster hashing algorithm - even if not as collision resistant as md5sum.
## however, since the md5sum hashing algorithm is currently not a speed limiting factor in running the script, this proposed improvment's advantage will only be evident on systems that use significantly faster secondary storage devices - like SSDs.


CSVStore="start, ";

if [ ! -d del ]; then mkdir del; fi;

appender(){
	echo "$currentFile is unique";
	CSVStore=$(echo "$CSVStore, $currentFileHash");
}

remover(){
	echo "*$currentFile is redundant";
	mv "$currentFile" ./del;
}

check(){
	echo "$CSVStore" | grep -c "$currentFileHash";
}

runLarge(){
	currentFileHash=$(echo $(head -c M "$currentFile")$(tail -c M "$currentFile") | md5sum | cut -c -32);
	if [ $(check) == "0" ]; then appender; else remover; fi;
}

runSmall(){
	currentFileHash=$(md5sum "$currentFile" | cut -c -32);
	if [ $(check) == "0" ]; then appender; else remover; fi;
}

run(){

	fileSize=$(du "$currentFile" | cut -c -"$(numcount "$(du "$currentFile")")");
	if [ "$fileSize" -lt 52428800 ]; then runSmall; else runLarge ; fi ;
	
}

## NEXT-V-RFC use a loop counter variable which will increment when a new redundance is found and if not incremented after the loop execution is done, say "no redundence found";

for currentFile in "$@"
do
	if [ -d "$currentFile" ]; then unredund.sh "$currentFile"/* ; else run; fi;
	done

## caveat -- if a previously 'unredund.sh'ed directory is re run without having removed the "del" directory created by the script, then the next time the script is run on the same directory the script will 
## most likely encounter the file contents in the "del" directory (since dir starts with d -- 4th letter an all) and consider the other copy - which is left as original by the previous run - redundant and also move it to the "del"
## directory which will effectively have removed both copies of the file -- so in the mean time dont run the script consecutively without first having cleaned the suggestions of the previous run.

## fixes -- prohibit running the script on all directories called "del"
## 		 -- or remove all non-empty directories called "del" before going forward with the rest of the op -- prompt user for confirmation --  never shall this script be allowed to delete files withous user interaction !! -- only relocate them to the "del" directory  when found necessary
##		 	-- navigate the directory hierarchy before running the rest of the script -- this way  much of the script - which is working fine will remain unchanged as all the change that will need doing will encapsulate this script as a part of the another which is in charge of executing this one after cleaning the hierarchy of all "del"s