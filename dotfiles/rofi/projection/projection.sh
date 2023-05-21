#!/bin/bash

primary="Primary screen only"
second="Second screen only"
duplicate="Duplicate"
extend_right="Extend to the right"
extend_left="Extend to the left"

choice="$(echo -e "$primary\n$second\n$duplicate\n$extend_right\n$extend_left" | rofi -dmenu -config ~/.config/rofi/projection/config.rasi)"

case $choice in
    $primary)
        profile="-o"
        ;;
    $second)
        profile="-s"
        ;;
    $duplicate)
        profile="-m"
        ;;
    $extend_right)
        profile="-e right"
        ;;
    $extend_left)
        profile="-e left"
        ;;
    *)
        exit 1
        ;;
esac

~/.config/mons/scripts/set.sh $profile
