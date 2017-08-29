#!/bin/bash
inotifywait -m /home/franz/Downloads -e create -e moved_to |
while read path action file; do
	echo "The file '$file' appeared in directory '$path' via '$action'"
	if [[ $file == *.txt || $file == *.pdf || $file == *.doc || $file == *.docx ]]; then
		mv $path/$file $path/Documents
	elif [[ $file == *.png || $file == *.jpg || $file == *.jpeg || $file == *.mp4 || $file == *.mov ]]; then
		mv $path/$file $path/Pictures
	fi    
done
