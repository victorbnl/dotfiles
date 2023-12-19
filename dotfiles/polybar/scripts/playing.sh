#!/bin/bash

# Exit if there is no active player
playerctl status 2>&1 > /dev/null
if [[ $? -eq 1 ]]
then
    echo ; exit
fi

# Exit if playing content is not music (album is empty)
if [[ -z "$(playerctl metadata album 2>/dev/null)" ]]
then
    echo ; exit
fi

# Print result
playerctl metadata -f "\{{title}} – \{{artist}}"
