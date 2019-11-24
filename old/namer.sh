#!/bin/bash
# Endrias A. D. 

for input in $@
do
	transientName=$(ffmpeg -i "$input" -ss 00:00:13.50 -vframes 1 -q:v 1 -f image2pipe - | tesseract stdin stdout );
	mv "$input" "$(echo $(echo "$transientName.mp4" | cut -c -6 -z --complement))";
done