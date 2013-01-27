#!/bin/bash

for i in *.mp3; do
  afconvert -f AIFC -d ima4 $i
done

# move new files to project directory
mv *.aifc ../ios_music/  