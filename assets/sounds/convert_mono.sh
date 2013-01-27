#!/bin/bash

for i in *.wav; do
  ffmpeg -i $i -acodec pcm_s16le -ar 22000 ../teste/$i
done

# move new files to project directory
