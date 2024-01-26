#!/bin/bash

# Input and output file names
input="input.MOV"
output="output.MOV"

# Get the duration of the video in seconds
duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input")
duration=${duration%.*}

# Temporary file pattern
tempfile="segment_%03d.MOV"

# Process the video in chunks
for ((i=0; i<$duration; i+=3)); do
    # Apply lagfun for the first 1 second of each 3-second chunk
    ffmpeg -i "$input" -ss $i -t 1 -vf "lagfun" -y $(printf "$tempfile" $((i/3*2+1)))

    # Check if there are at least 2 more seconds left in the video
    if (( i+2 < duration )); then
        # Copy the next 2 seconds without any effect
        ffmpeg -i "$input" -ss $(($i + 1)) -t 2 -y $(printf "$tempfile" $((i/3*2+2)))
    fi
done

# Create a list of all segments
for ((i=1; i<=duration/3*2; i++)); do
    echo "file '$(printf "$tempfile" $i)'" >> mylist.txt
done

# Concatenate all segments using a consistent codec
ffmpeg -f concat -safe 0 -i mylist.txt -c:v libx264 -c:a aac "$output"

# Clean up temporary files
rm segment_*.MOV mylist.txt
