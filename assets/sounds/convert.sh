#!/bin/bash

for i in *.wav; do
  afconvert -f caff -d LEI16@22050 -c 1 $i
done

# move new files to project directory
mv *.caf ../ios_sounds/  