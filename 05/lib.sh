#!/bin/bash

function ouputDirInfo() {
    local fpath=$1

    local totalFolders=$(find $fpath -type d | wc -l)
    local list+=("Total number of folders (including all nested ones) = $totalFolders")

    local topFiveFolders=$(du -h $fpath*/ 2>/dev/null | sort -rh | head -n 5 | \
    awk '{if (substr($2, length($2)) != "/") $2 = $2 "/"; print FNR " - " $2 ", " $1}' \
    | column -t)
    list+=("TOP 5 folders of maximum size arranged in descending order (path and size):")
    list+=("$topFiveFolders")

    local fileNum=$(find $fpath -type f | wc -l) 
    list+=("Total number of files = $fileNum")

    local confF=$(find $fpath -type f -name "*.conf" | wc -l) && confF=${confF:-0}
    local textF=$(find $fpath -type f -name "*.txt" -o -name "*.md" \
    | wc -l) && textF=${textF:-0}
    local execF=$(find $fpath -type f -executable | wc -l) && execF=${execF:-0}
    local logF=$(find $fpath -type f -name "*.log" | wc -l) && logF=${logF:-0}
    local archF=$(find $fpath -type f  \
     -name "*.tar.gz" -o -name "*.zip" -o -name "*.tar" -o -name "*.rar"  \
    | wc -l) && archF=${archF:-0}
    local links=$(find $fpath -type l | wc -l) && links=${links:-0}

    list+=(
        "Number of:\nConfiguration files (with the .conf extension) = $confF"
        "Text files = $textF"
        "Executable files = $execF"
        "Log files (with the extension .log) = $logF"  
        "Archive files = $archF"
        "Symbolic links = $links"
    )

    list+=("TOP 10 files of maximum size arranged in descending order (path, size and type):")
    local topTenF=$(find $fpath -type f -exec ls -sh {} + \
    | sort -rh \
    | head -n 10 \
    | awk '{print NR " - " $1 ", " $2 }') \

    IFS=$'\n'
    for ext in ${topTenF[@]}; do
        tmp=$ext
        ext=$(echo $ext | awk -F '/' '{if(match($NF, /^[^\/]+$/)) {print $NF;} else {print "";}}')
        IFS=$'.' read -r _ ext <<< $ext
        arrayString+=$(echo "$tmp $ext\n")
    done
    topTenF=$(echo -e $arrayString | awk '{lines[NR] = $1" "$2" "$4", "$3" "$5} END { for (i=1;i<NR;i++) print lines[i]}' | column -t)

    list+=("$topTenF")

    list+=("TOP 10 executable files of the maximum size arranged in \
descending order (path, size and MD5 hash of file)")

    local topTenExeF=$(find "$fpath" -type f -executable \
    -exec sh -c 'echo $(ls -sh {} | awk "{printf \"%s %s \", \$2, \$1}" && md5sum {})' \; \
    | awk '{print $1 ", " $2 ", " $3}' \
    | sort -rh -k2,2rn \
    | head -n 10 \
    | awk '{print NR " - "$1 " " $2 " " $3}' \
    | column -t )
    
    list+=("$topTenExeF")

    endTime=$(date +%s.%3N)
    local execution_time=$(echo "$endTime - $startTime" | bc)
    list+=("Script execution time (in seconds) = ${execution_time}")    
    
    IFS=$'\n'
    for out in ${list[@]}; do
        echo -e $out
    done
}
