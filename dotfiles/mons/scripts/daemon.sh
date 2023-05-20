#!/bin/bash

case ${MONS_NUMBER} in
    1)
        mons -o
        ;;
    2)
        last=$(cat ~/.config/mons/last)
        if [ ! -z "$last" ]; then
            mons $last
        else
            mons -o
        fi
        ;;
esac

~/.config/mons/scripts/post.sh
