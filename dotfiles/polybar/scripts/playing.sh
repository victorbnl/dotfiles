#!/bin/bash

# Get metadata
player_not_running=false
title=$(playerctl metadata title 2>/dev/null) || player_not_running=true
artist=$(playerctl metadata artist 2>/dev/null) || player_not_running=true

# Ensure played content is music by getting its album
album=$(playerctl metadata album 2>/dev/null) || player_not_running=true
if [[ -z "$album" ]]
then
    player_not_running=true
fi

# Format and echo output
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
