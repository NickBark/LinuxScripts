#!/bin/bash
startTime=$(date +%s.%3N)

. lib.sh

reg='^(.*)[/]$'

if [ $# -ne 1 ]; then
    echo "Wrong number of arguments" >&2 && exit 1
elif ! [[ $1 =~ $reg ]]; then
    echo "Wrong path to the directory" >&2 && exit 1
elif ! [ -d $1 ]; then
    echo "The directory does not exist" >&2 && exit 1
else 
    ouputDirInfo $1
fi
