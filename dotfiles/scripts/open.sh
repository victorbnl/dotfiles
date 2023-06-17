#!/bin/bash

case $1 in
    file-manager)
        $FILE_MANAGER
        ;;
    lockscreen)
        $LOCKSCREEN
        ;;
    terminal)
        $TERMINAL
        ;;
esac
