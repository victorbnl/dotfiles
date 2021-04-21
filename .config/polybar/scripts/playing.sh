#!/bin/bash

output=$(playerctl metadata title 2>&1)

if [ "$output" != "No players found" ]; then
	echo "$output"
fi
