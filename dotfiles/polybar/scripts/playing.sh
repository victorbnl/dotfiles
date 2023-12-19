#!/bin/bash

playerctl status > /dev/null 2>&1
if [[ $? -eq 1 || -z "$(playerctl metadata album 2>/dev/null)" ]]
then
    echo
else
    playerctl metadata -f "\{{title}} – \{{artist}}" 2>/dev/null
fi
