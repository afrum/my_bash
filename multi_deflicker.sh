#! /bin/sh

# explanation = see link: https://github.com/afrum/my_ffmpeg/blob/main/deflicker

for i in {0..9}
do
ffmpeg -i input$i.MOV -an -vcodec rawvideo -pix_fmt yuv420p rawbitstream$i.yuv

ffmpeg -r 2 -s 1920x1080 -i rawbitstream$i.yuv -filter:v select="not(mod(n-1\,2))" -c:v rawvideo -r 1 -format rawvideo -pix_fmt yuv420p -an even$i.yuv

ffmpeg -r 2 -s 1920x1080 -i rawbitstream$i.yuv -filter:v select="mod(n-1\,2)" -c:v rawvideo -r 1 -format rawvideo -pix_fmt yuv420p -an odd$i.yuv


ffmpeg -s 1920x1080 -i even$i.yuv even$i.MOV
ffmpeg -s 1920x1080 -i odd$i.yuv odd$i.MOV
ffmpeg -i even$i.MOV -vf "setpts=1.67*PTS" Slowed-even$i.MOV
ffmpeg -i odd$i.MOV -vf "setpts=1.67*PTS" Slowed-odd$i.MOV
rm *.yuv
done
