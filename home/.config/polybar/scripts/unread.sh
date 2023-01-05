#!/bin/bash

function getFerdiumProperty()
{
    raw=$(busctl --user get-property org.ferdium.Ferdium /org/ferdium org.ferdium.Ferdium $1 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        echo "${raw:2}"
    else
        echo -1
    fi
}

function getUnreadCount()
{
    unreadDirectMessageCount=$(getFerdiumProperty UnreadDirectMessageCount)
    if [[ "$unreadDirectMessageCount" -ne -1 ]]; then
        unreadIndirectMessageCount=$(getFerdiumProperty UnreadIndirectMessageCount)
        echo $(($unreadDirectMessageCount + $unreadIndirectMessageCount))
    fi
}

function getDunstStatusIcon()
{
    if [ "$(dunstctl is-paused)" = "true" ]
    then
        echo ""
    else
        echo ""
    fi
}

icon=$(getDunstStatusIcon)
count=$(getUnreadCount)

out="$icon"
if [[ "$count" != "" ]]
then
    out+=" $count"
fi

echo "$out"
