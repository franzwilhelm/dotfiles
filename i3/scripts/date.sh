#!/bin/bash
add=""
if [ $BLOCK_BUTTON == 1 ]; then 
	com.github.thejambi.dayjournal
fi

hour=`date '+%H'`
if (( $hour >= 22 )); then
	add=" Husk å skrive i dagboka! | "
fi	
echo $add `date '+%d.%m.%Y %H:%M'`
