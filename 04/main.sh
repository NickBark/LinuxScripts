#!/bin/bash

. colors.sh

if [ -f "conf.conf" ]; then
    exec 0< conf.conf
else
    echo "File conf.conf not exist" >&2 && exit 1
fi

if [ $# -gt 0 ]; then
    echo "Too many arguments"; exit 1
else
    for ((i=0; i < 4; i++)); do
        list[$i]=${defaultColors[$i]}
    done

    i=0
    reg='^[1-6]$'
    while read line; do
        if [ $i -gt 3 ]; then
            break;  
        elif ! [[ ${line#*=} =~ $reg ]]; then
            i=$(($i+1))
            continue
        else
            list[$i]=${line#*=}
            i=$(($i+1))
        fi
    done

    if [[ ${list[0]} == ${list[1]} || ${list[2]} == ${list[3]} ]]; then
        echo "The colors of the font and background in one column should not match"
        echo "Please run the script with correct values"; exit 0
    else 
        ./variables.sh ${list[0]} ${list[1]} ${list[2]} ${list[3]}
        echo
        echo "Column 1 background = ${list[0]} ${colorNames[${list[0]} - 1]}"
        echo "Column 1 font color = ${list[1]} ${colorNames[${list[1]} - 1]}"
        echo "Column 2 background = ${list[2]} ${colorNames[${list[2]} - 1]}"
        echo "Column 2 font color = ${list[3]} ${colorNames[${list[3]} - 1]}"
    fi
fi

