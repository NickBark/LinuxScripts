#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Wrong number of arguments" && exit 1
else
    if [ -f core.sh ]; then 
        ./core.sh $1
    else
        echo "somebody destroy the core"
    fi
fi
