#!/bin/bash

strippedFilename="/var/cache/curl/$3stripped.html";
#linksFilename="/var/cache/curl/$3links.html";

sudo http "$1" | grep -i "<tr><td><a href=" | grep -i "</a></td><td>" | grep -i "</td></tr>" | grep -v "<tbody>" | cut --complement -c -17 > "$strippedFilename";


## synopsis 

### urlstrip.sh "the url to the static parent directory" "the file extension to download from the parent directory" "name of the project"
