#!/bin/bash

status="$(playerctl status 2>&1)"
if [[ $? -eq 1 || -z "$(playerctl metadata album 2>/dev/null)" ]]
then
    echo
else
    if [[ "$status" == "Paused" ]]
    then
        symbol=''
    else
        symbol=''
    fi
    playerctl metadata -f "$symbol  \{{title}} – \{{artist}}" 2>/dev/null
fi
