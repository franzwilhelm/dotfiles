#!/bin/bash
if [ $BLOCK_BUTTON == 1 ]; then
	ignore=`gnome-control-center network`
fi
echo $(iwgetid -r)
