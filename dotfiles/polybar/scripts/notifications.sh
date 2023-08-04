#!/bin/bash

while [[ $# -gt 0 ]]
do
    case $1 in
        --icon)
            shift
            normal_icon=$1
            ;;
        --muted-icon)
            shift
            muted_icon=$1
            ;;
        *)
            shift
            ;;
    esac
done

function get()
{
    raw=$(busctl --user get-property org.ferdium.Ferdium /org/ferdium org.ferdium.Ferdium $1 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        echo "${raw:2}"
    else
        echo -1
    fi
}

count=""
direct=$(get UnreadDirectMessageCount)
if [[ "$direct" -ne -1 ]]
then
    indirect=$(get UnreadIndirectMessageCount)
    count=$((direct + indirect))
fi

muted=$(dunstctl is-paused)
if [[ "$muted" == "true" ]]
then
    icon=$muted_icon
else
    icon=$normal_icon
fi

out=$icon
if [[ "$count" != "" ]]
then
    out+="  $count"
fi
echo "$out"
