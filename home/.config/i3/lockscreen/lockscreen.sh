#!/bin/bash

NONE=00000000
FG=FFFFFF80
BG=FFFFFF60
WRONG=FF0000FF

function getWallpaper() {
    grep -oP "file=\K.*" ~/.config/nitrogen/bg-saved.cfg
}

image=$(getWallpaper)

i3lock \
    -i "$image" --scale \
    --color=000000FF \
    --inside-color="$NONE" \
    --insidever-color="$NONE" \
    --insidewrong-color="$NONE" \
    --ring-width=12 \
    --ring-color="$BG" \
    --ringver-color="$BG" \
    --ringwrong-color="$WRONG" \
    --keyhl-color="$FG" \
    --line-color="$NONE" \
    --separator-color="$BG" \
    --verif-text="" \
    --wrong-text="" \
    --noinput-text="" \
    --no-modkey-text
