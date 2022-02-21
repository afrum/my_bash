#! /bin/bash

inputvideo=input.mkv

# the number for the video PTS is the reciprocal for the audio and viceversa.
# keep between .5 and 2 in order to get the best results.
# to speed up or slow down more you can run command multiple times.

speedvideo=2
speedaudio=1/$speedvideo
outputvideo=output.mkv

ffmpeg -i $inputvideo -filter_complex "[0:v]setpts=$speedvideo*PTS[v],[0:a]atempo=$speedaudio[a]" -map "[v]" -map "[a]" $outputvideo

# link https://trac.ffmpeg.org/wiki/How to speed up / slow down a video
