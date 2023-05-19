#!/bin/bash

case $1 in
    terminal)
        $TERMINAL
        ;;
    file-manager)
        $FILE_MANAGER
        ;;
esac
