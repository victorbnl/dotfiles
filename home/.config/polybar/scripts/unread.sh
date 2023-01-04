#!/bin/bash

function getFerdiumProperty()
{
    raw=$(busctl --user get-property org.ferdium.Ferdium /org/ferdium org.ferdium.Ferdium $1)
    echo "${raw:2}"
}

function getUnreadCount()
{
    unreadDirectMessageCount=$(getFerdiumProperty UnreadDirectMessageCount)
    unreadIndirectMessageCount=$(getFerdiumProperty UnreadIndirectMessageCount)

    echo $(($unreadDirectMessageCount + $unreadIndirectMessageCount))
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

echo "$(getDunstStatusIcon) $(getUnreadCount)"
