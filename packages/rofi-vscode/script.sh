#!/usr/bin/env bash

function fix() {
    while read line
    do
        echo -e "${line/#\~/$HOME}\0icon\x1fvscode"
    done
}

choice="$($VSCODE_RECENT | fix | rofi -dmenu)"

if [ ! -z "$choice" ]
then
    code --new-window "$choice"
fi
