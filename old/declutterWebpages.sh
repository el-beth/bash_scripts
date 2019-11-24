#!/bin/bash

## use this script to move webpages and their _files directory to a single folder called $outputDirectory - maily to declutter a system
## before using the script copy the script to the directory you want to declutter and pass the following argument to your shell, ./declutterWebpages.sh "*" and there will be a new directory destz or any name specified in this script for the variable outputDirectory.

outputDirectory="destz";
notificationDestzFound="directory $outputDirectory found.\n";

if [ -e $outputDirectory ]
    then if [ -d $outputDirectory ]
        then printf "$notificationDestzFound";
    else mkdir $outputDirectory;
    fi;
else mkdir "$outputDirectory";
fi;
    
for currentFile in $@
do
    egrepResult="$( echo "$currentFile" | egrep -e '.*\.html' )";
    if [ -z "$egrepResult" ]
        then egrepBool="no";
    else egrepBool="yes";
    fi;
    if [ $egrepBool == "yes" ] ;
        then
            stringLength=$(strlen "$currentFile");
            coreLength=$( subtract $stringLength 5 );
            coreName=$( echo $currentFile | cut -c -"$coreLength" );
            htmlFile="$coreName".html;
            htmlDir="$coreName"_files;
            if [ -d $htmlDir ]
                then mv "$htmlFile" "$htmlDir" "$outputDirectory";
            else
                echo "$htmlDir not found, moving $htmlFile alone.";
                mv "$htmlFile" "$outputDirectory";
            fi;
        fi
    shift;
done;
