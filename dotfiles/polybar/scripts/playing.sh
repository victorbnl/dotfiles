#!/bin/bash

no_player=false
title=$(playerctl metadata title 2>/dev/null) || no_player=true
artist=$(playerctl metadata artist 2>/dev/null) || no_player=true

if [[ $no_player == true ]]
then
    echo ""
else
    echo "$artist − $title"
fi
