#!/usr/bin/env bash

function iconify() {
    while read line
    do
        echo -e "$line\0icon\x1fvscode"
    done
}

choice="$($VSCODE_RECENT | iconify | rofi -dmenu)"

if [ ! -z "$choice" ]
then
    code --new-window "$choice"
fi
