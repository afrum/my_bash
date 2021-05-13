#! /bin/bash

# insert video names below(base video, middle video, top video)
video=("blank.MOV" "intro.MOV" "body.MOV")

# insert the size to scale each video
size=("1920x1080" "1920x1080" "1920x1080")

# insert any delays? no delay is "-STARTPTS", "+10/TB" is a 10 second delay
delay=("-STARTPTS" "-STARTPTS" "+5/TB")

# insert start time and end time(in seconds) of the middle and top video
starttime=(0 0)
endtime=(5 300)

ffmpeg -i ${video[0]} -i ${video[1]} -i ${video[2]} -filter_complex \
"nullsrc=size=${size[0]} [base]; \
[0:v] setpts=PTS${delay[0]}, scale=${size[0]} [bg];\
[1:v] setpts=PTS${delay[1]}, scale=${size[1]} [1st];\
[2:v] setpts=PTS${delay[2]}, scale=${size[2]} [2nd];\
[base][bg] overlay=shortest=1 [tmp1];\
[tmp1][1st] overlay=enable='between(t,${starttime[0]},${endtime[0]})'[tmp2];\
[tmp2][2nd] overlay=enable='between(t,${starttime[1]},${endtime[1]})'"\
 -c:v libx264 overlay3.MOV

