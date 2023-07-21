#!/bin/bash

. variables.sh

if [ $# -gt 0 ]; then
    echo "Too many arguments"; exit
fi

for info in ${listOfVariables[@]}; do
    echo $info
done 

echo; read -p "Would you like to write data to a file? (Y/N): " choice

if [[ $choice = 'Y' ||  $choice = 'y' ]]; then
    for info in ${listOfVariables[@]}; do
        echo $info
    done > $(date +"%d_%m_%y_%H_%M_%S.status")
fi