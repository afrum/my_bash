#! /bin/bash
# to trim multiple videos from a csv file called times.csv
# the format in the csv file is video_name,start_time,end_time,crop
#     video_name is the videos name, including address if not in current folder
#     start_time is the start of the trim,example of formats seconds e.g 135.5 or minutes:seconds e.g 2:15.5
#     end_time is the time at the input video that you want to stop your output video
#     crop if you want to crop the video, format is x-axis:y-axis:width:height e.g. 100:150:600:650
# link to my video about this script https://youtu.be/QdBcfw4dtkI


i=0

while IFS="," read f1 f2 f3 f4 
do
	
	
	ffmpeg -i $f1 -ss $f2 -to $f3 -vf crop=$f4 outtimecrop_$i.MOV </dev/null
	i=$((i+1))

done < timecrop.csv


# see the link below for why I use </dev/null at the end
# https://unix.stackexchange.com/questions/36310/strange-errors-when-using-ffmpeg-in-a-loop
