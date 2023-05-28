#!/bin/bash

player=$1

player_not_running=false
title=$(playerctl -p $player metadata title 2>/dev/null) || player_not_running=true
artist=$(playerctl -p $player metadata artist 2>/dev/null) || player_not_running=true

out=""
if [[ $player_not_running == false ]]
then
    if [[ $artist != "" ]]
    then
        out+="$artist − "
    fi
    out+="$title"
fi
echo "$out"
