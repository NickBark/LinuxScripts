#!/bin/bash

reg='^[1-6]$'

if [ $# -gt 4 ]; then
    echo "Too many arguments" >&2; exit 1;
elif [ $# -le 3 ]; then
    echo "Too few arguments" >&2; exit 1;
elif [[ $1 == $2 || $3 == $4 ]]; then
    echo "The colors of the font and background in one column should not match"
    echo "Please run the script with correct values"; exit 0
else
    for arg in $@; do
        if ! [[ $arg =~ $reg ]]; then
            echo "Incorrect arguments" >&2; exit 1
        fi
    done
    ./variables.sh $1 $2 $3 $4
fi