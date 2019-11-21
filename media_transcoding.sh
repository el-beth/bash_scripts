#!/bin/bash

# this script is particularly for converting to the mp4 container spec i.e.  H264 - MPEG-4 AVC(part 10)(avc1) encoded video and MPEG AAC (mp4a) encoded audio
# will not overwrite already existing files
# to use this script in the most straightforward manner, go to the directory that contains the files to be transcoded and run media_transcoding.sh "*" -- don't forget the quotes in the calling argument 

for input in $@
do
	# prepare output name
	outputname=$(rmext "$input");
	ffmpeg -n -nostdin -i "$input" "$outputname.mp4";
	shift;
done