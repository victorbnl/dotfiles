#!/bin/bash

chosen=$(echo -e "Shutdown\nReboot\nSuspend\nHibernate\nHibernate suspend" | rofi -no-show-icons -dmenu -i -p "Power")

if [[ $chosen = "Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "Reboot" ]]; then
	systemctl reboot
elif [[ $chosen = "Suspend" ]]; then
	systemctl suspend
elif [[ $chosen = "Hibernate" ]]; then
	systemctl hibernate
fi
