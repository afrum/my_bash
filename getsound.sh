#! /bin/bash

# making a .mp3 file for every .MOV file I have in current folder

for file in *.MOV;
 do 
	ffmpeg -i "$file" "${file%.MOV}".mp3;
 done



# https://askubuntu.com/questions/511461/run-command-for-every-file-in-directory
