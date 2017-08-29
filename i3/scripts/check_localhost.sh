#!/bin/bash
out=""
api=`netstat -tulpn | awk '/-api/' | awk '{print $7}'`
node=`netstat -tulpn | awk '/node/' | awk '{print $7}'`
if [ "$api" != "" ]; then
	port=`netstat -tulpn | awk '/-api/' | awk '{print $4}'`
	url="http://localhost:${port:3}"
	out+="<span color='#f04c5c'>bee</span> ⇄ <span color='#4cbdff'>${port:3}</span>"
	if [ "$node" != "" ]; then
		out+=" | "
	fi
fi

if [ "$node" != "" ]; then
	port=`netstat -tulpn | awk '/node/' | awk '{print $4}'`
	url="http://localhost:${port:3}"
	out+="n<span  color='#41873f'>⬢</span>de ⇄ <span color='#4cbdff'>${port:3}</span>"
fi

if [ $BLOCK_BUTTON == 1 ]; then
	xdg-open $url
fi

echo "<span color='white'>${api:6:-4} ($out)</span>"
