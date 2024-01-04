#!/bin/bash

RES=$(xdpyinfo | awk '/dimensions/{print $2}')
BLUR=25

mkdir -p output
convert input.jpg -resize $RES^ -gravity center -extent $RES output/desktop.jpg
convert output/desktop.jpg -blur 0x$BLUR output/lock.jpg
feh --bg-fill output/desktop.jpg
