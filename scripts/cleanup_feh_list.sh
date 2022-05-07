#!/bin/bash

# for each jpg file in the dirctory, check whether exists in feh-filelist
# if no, delete it

if [ -e feh_*_filelist ]; then
	for i in $(find \( -iname \*.jpg -o -iname \*.jpeg \)); do
		if ! grep -q "$i" feh_*_filelist; then
			echo "Deleting: $i"
			#rm "$i"
		fi
	done
	rm feh_*_filelist
else
	echo "cant find feh filelist. exiting"
fi

