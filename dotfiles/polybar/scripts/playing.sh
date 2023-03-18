#!/bin/bash

no_player=false
title=$(playerctl metadata title 2>/dev/null) || no_player=true
artist=$(playerctl metadata artist 2>/dev/null) || no_player=true

out=""
if [[ $no_player == false ]]
then
    if [[ $artist != "" ]]
    then
        out+="$artist − "
    fi
    out+="$title"
fi
echo "$out"
