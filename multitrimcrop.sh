#! /bin/bash
# to trim multiple videos from a csv file called times.csv
# the format in the csv file is video_name,start_time,end_time
# link to my video about this script https://youtu.be/QdBcfw4dtkI


i=0

while IFS="," read f1 f2 f3 f4 
do
	
	
	ffmpeg -i $f1 -ss $f2 -to $f3 -vf crop=$f4 outtimecrop_$i.MOV </dev/null
	i=$((i+1))

done < timecrop.csv


# see the link below for why I use </dev/null at the end
# https://unix.stackexchange.com/questions/36310/strange-errors-when-using-ffmpeg-in-a-loop
