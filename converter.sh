#!/bin/bash

## this script is used to manipulate the negarit gazette png images. to this effect is removes a fixed amount of pixels from the four corners of the image. if the images being worked on are of equal size, the resultant images will also be of equal size

mkdir fin;
for working in $@
do
	convert $working -chop 34x72 -rotate 180 -chop 198x8 -rotate 180 fin/"$working" ;
	shift;
done;
