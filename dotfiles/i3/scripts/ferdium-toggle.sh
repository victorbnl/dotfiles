#!/bin/bash

muted=$(busctl --user get-property org.ferdium.Ferdium /org/ferdium org.ferdium.Ferdium Muted 2>/dev/null)

if [[ "$muted" == "b true" ]]
then
    new_val="false"
else
    new_val="true"
fi

busctl --user set-property org.ferdium.Ferdium /org/ferdium org.ferdium.Ferdium Muted b $new_val
