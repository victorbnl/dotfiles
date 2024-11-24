#!/usr/bin/env bash

shutdown=''
reboot=''
lock=''
suspend='󰤄'
logout='󰗼'

choice=$(echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi -dmenu -config $CONFIG_FILE)

case ${choice} in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        loginctl lock-session
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        i3-msg exit
        ;;
esac
