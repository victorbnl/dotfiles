#!/usr/bin/env bash

function process() {
    while read line
    do
        [ -d "$line" ] && echo -e "$line\0icon\x1fvscode"
    done
}

choice="$($VSCODE_RECENT --output-format absolute-path | process | rofi -dmenu)"

if [ ! -z "$choice" ]
then
    code --new-window "$choice"
fi
