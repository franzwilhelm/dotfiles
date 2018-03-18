#!/bin/bash
inotifywait -m /home/franz/Downloads -e create -e moved_to |
while read path action file; do
	if [[ $file != *.crdownload ]]; then
		echo "The file '$file' appeared in directory '$path' via '$action'"
		INF1300=`echo $file | grep INF1300`
		INF2220=`echo $file | grep INF2220`
		MAT1100=`echo $file | grep MAT1100`
		if [[ $INF1300 != "" ]]; then
			mkdir $path/INF1300
			mv $path/$file $path/"INF1300"
		elif [[ $INF2220 != "" ]]; then
			mkdir $path/INF2220
			mv $path/$file $path/"INF2220"
		elif [[ $MAT1100 != "" ]]; then
			mkdir $path/MAT1100
			mv $path/$file $path/"MAT1100"
		elif [[ $file == *.txt || $file == *.pdf || $file == *.doc || $file == *.docx ]]; then
			mv $path/$file $path/Documents
		elif [[ $file == *.png || $file == *.jpg || $file == *.jpeg || $file == *.mp4 || $file == *.mov ]]; then
			mv $path/$file $path/Pictures
		fi
	fi
done
