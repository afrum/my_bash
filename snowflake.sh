#! /bin/bash

#make a flake 300x300 pixels name it flake.png using your choice of art tool

#make a background blank image
magick -size 520x520 xc:black bg.png

#creates a triangle segment for masks for hex shape

#first mask
magick -size 520x520 xc:white -fill black -draw "polygon 260,260 110,520 410,520" masktriangle.png
# other masks

for angle in 60 120 240 300; do
    magick masktriangle.png -rotate $angle -gravity center masktriangle$angle.png
done

for angle in 180 360; do
    magick masktriangle.png -rotate $angle -gravity center -background white -extent 712x712 masktriangle$angle.png
done

#use mask on flake to get triangle shape
# the command is composite [foreground image] [background image] -negate to inverse the mask [mask image] -gravity South to align foreground and then [output filename]
composite flake.png bg.png -negate masktriangle.png -gravity South  templateflake.png

for angle in 60 120 240 300; do
    magick templateflake.png -background black -rotate $angle -gravity Center flake$angle.png
done
  
for angle in 180 360; do
    magick templateflake.png -background black -rotate $angle -gravity Center -background black -extent 712x712 flake$angle.png
done

#combine the flakes to make one full snowflake

composite flake60.png flake360.png masktriangle360.png ahex360.png
composite ahex360.png flake120.png masktriangle120.png ahex360a.png
composite ahex360a.png flake180.png masktriangle180.png ahex360b.png
composite ahex360b.png flake240.png masktriangle240.png ahex360c.png
composite ahex360c.png flake300.png masktriangle300.png finalsnowflake.png



