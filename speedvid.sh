#! /bin/bash

inputvideo=input.mkv

# to sync video and audio the video PTS is the reciprocal for the audio and viceversa.
# keep between .5 and 2 in order to get the best results.
# to speed up or slow down more you can run command multiple times.
# 2 for video speed slows the video by half .5 speeds the video up to double speed.
# 2 for audio speed speeds the audio up to double speed .5 slows it to half speed.


speedvideo=2
speedaudio=1/$speedvideo
outputvideo=output.mkv

ffmpeg -i $inputvideo -filter_complex "[0:v]setpts=$speedvideo*PTS[v],[0:a]atempo=$speedaudio[a]" -map "[v]" -map "[a]" $outputvideo

# link https://trac.ffmpeg.org/wiki/How to speed up / slow down a video
