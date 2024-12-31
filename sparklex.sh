#!/bin/bash

# Create a directory for the frames
mkdir -p fireworks_frames

# Parameters
total_frames=10
max_dots=100
x_center=400
y_center=400
dot_size_min=1
dot_size_max=5
max_radius=400

# Generate the frames
for t in $(seq 1 $total_frames); do
  frame="fireworks_frames/frame_$(printf "%02d" $t).png"
  # Create a black canvas for the current frame
  magick -size 800x800 xc:black "$frame"
  
  # Draw the dots
  for ((i=0; i<max_dots; i++)); do
    # Simplified method to place dots in a circular pattern
    angle=$((RANDOM % 360)) # Random angle in degrees
    radius=$((RANDOM % max_radius)) # Random radius
    
    # Approximate x, y using integer operations. This is a crude approximation.
    # For simplicity, we'll use a square to approximate the circle's quadrant.
    if [ $angle -lt 90 ]; then
      x=$((x_center + radius))
      y=$((y_center - radius))
    elif [ $angle -lt 180 ]; then
      x=$((x_center - radius))
      y=$((y_center - radius))
    elif [ $angle -lt 270 ]; then
      x=$((x_center - radius))
      y=$((y_center + radius))
    else
      x=$((x_center + radius))
      y=$((y_center + radius))
    fi
    
    # Random size and opacity for twinkling effect
    size=$((RANDOM % ($dot_size_max - $dot_size_min + 1) + $dot_size_min))
    opacity=$((RANDOM % 100 + 1))%
    
    # Draw the dot
    magick "$frame" \
      -fill "rgba(255,255,255,$opacity)" \
      -draw "circle $x,$y $x,$((y + size))" \
      "$frame"
  done
  
  # Optional: Add a slight blur for a softer effect
  magick "$frame" -blur 0x0.5 "$frame"
done

# Create the GIF from the frames
magick -delay 10 fireworks_frames/frame_*.png -loop 0 fireworks_animation.gif

echo "GIF created: fireworks_animation.gif"
