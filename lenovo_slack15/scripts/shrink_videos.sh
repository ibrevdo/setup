#!/bin/bash

for f in *.mp4; do
    f1=${f::-4}_.mp4
    #echo $f ${f::-4}
    ffmpeg -i $f -map_metadata 0 -vf "scale=trunc(iw/4)*2:trunc(ih/4)*2" $f1
    yes | ffmpeg -i $f1 -map_metadata 0 -vcodec libx265 -crf 28 ${f1::-5}.mp4
done
rm *_.mp4
