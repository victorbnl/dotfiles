#!/bin/bash

ICON_NORMAL=''
ICON_MUTED=''

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
    icon=$ICON_MUTED
else
    icon=$ICON_NORMAL
fi

out=$icon
if [[ "$count" != "" ]]
then
    out+="  $count"
fi
echo "$out"
