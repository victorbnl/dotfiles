#!/bin/bash

zscroll -l 30 \
	--delay 0.5 \
	--update-check true "playerctl metadata title" &

wait
