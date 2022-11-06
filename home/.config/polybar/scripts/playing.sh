#!/bin/bash

playing=$(playerctl metadata title 2>&1)

if [[ $? -eq 0 ]]; then
	echo "$playing"
fi
