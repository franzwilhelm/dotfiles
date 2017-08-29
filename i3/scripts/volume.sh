#!/bin/bash
vol=`awk -F"[][]" '/Right/ { print $2 }' <(amixer -D pulse sget Master)`
echo ${vol:-3}
