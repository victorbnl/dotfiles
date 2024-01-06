#!/bin/bash

RES=$(xdpyinfo | awk '/dimensions/{print $2}')
BLUR=25
LOCK_SIZE=150

mkdir -p output
convert input.jpg -resize $RES^ -gravity center -extent $RES output/desktop.jpg
convert output/desktop.jpg -blur 0x$BLUR output/login.jpg
convert output/login.jpg assets/lock.png -gravity center -geometry ${LOCK_SIZE}x${LOCK_SIZE}+0+0 -composite output/lock.jpg
feh --bg-fill output/desktop.jpg
