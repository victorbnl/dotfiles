#!/bin/bash

IMAGE=~/.config/i3/lockscreen/background.jpg
NONE=00000000
FG=FFFFFF80
BG=FFFFFF60
WRONG=FF0000FF

i3lock \
    -i "$IMAGE" \
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
