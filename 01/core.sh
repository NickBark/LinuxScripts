#!/bin/bash

reg='^[+-]?[0-9]+([.][0-9]+)?$'

if [[ $1 =~ $reg ]]; then
    echo "bad input, it's a number" && exit
else 
    echo $1
fi