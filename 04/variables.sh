#!/bin/bash

. colors.sh

pref="${backColors[$1 - 1]}${fontColors[$2 - 1]}"
post="${backColors[$3 - 1]}${fontColors[$4 - 1]}"

hostname=$(hostname)
timezone=$(timedatectl | awk '/Time zone/{print $3 " " $4 $5}'| tr -d '()')
user=$(whoami)
os=$(lsb_release -d | awk '{print $2 " " $3 " " $4}')
date=$(date +"%d %b %Y %T")
uptime=$(uptime -p | awk '{for(i = 2; i <= NF; i++) printf "%s ", $i}')
uptime_sec=$(awk '{print $1}' /proc/uptime)
ip=$(hostname -I | awk '{print $1}')
mask=$(ifconfig | grep "$ip" | awk '{print $4}')
gateway=$(ip route | awk '/default/{print $3}')
ram_total=$(free | awk 'NR==2 {printf "%.3f GB\n", $2/1024/1024}')
ram_used=$(free | awk 'NR==2 {printf "%.3f GB\n", $3/1024/1024}')
ram_free=$(free | awk 'NR==2 {printf "%.3f GB\n", $4/1024/1024}')
space_root=$(df | awk 'NR==3 {printf "%.2f MB", $2/1024}')
space_root_used=$(df | awk 'NR==3 {printf "%.2f MB", $3/1024}')
space_root_free=$(df | awk 'NR==3 {printf "%.2f MB", $4/1024}')

IFS=$'\n'
listOfVariables=(""$pref"HOSTNAME ="$post"$hostname \033[0m")
listOfVariables+=(""$pref"TIMEZONE ="$post"$timezone \033[0m")
listOfVariables+=(""$pref"USER ="$post"$user \033[0m")
listOfVariables+=(""$pref"OS ="$post"$os \033[0m")
listOfVariables+=(""$pref"DATE ="$post"$date \033[0m")
listOfVariables+=(""$pref"UPTIME ="$post"$uptime \033[0m")
listOfVariables+=(""$pref"UPTIME_SEC ="$post"$uptime_sec \033[0m")
listOfVariables+=(""$pref"IP ="$post"$ip\033[0m")
listOfVariables+=(""$pref"MASK ="$post"$mask\033[0m")
listOfVariables+=(""$pref"GATEWAY ="$post"$gateway\033[0m")
listOfVariables+=(""$pref"RAM_TOTAL ="$post"$ram_total\033[0m")
listOfVariables+=(""$pref"RAM_USED ="$post"$ram_used\033[0m")
listOfVariables+=(""$pref"RAM_FREE ="$post"$ram_free\033[0m")
listOfVariables+=(""$pref"SPACE_ROOT ="$post"$space_root\033[0m")
listOfVariables+=(""$pref"SPACE_ROOT_USED ="$post"$space_root_used\033[0m")
listOfVariables+=(""$pref"SPACE_ROOT_FREE ="$post"$space_root_free\033[0m")

for info in ${listOfVariables[@]}; do
    echo -e $info
done