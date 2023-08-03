# Directories
dir="$HOME/.config/rofi/powermenu"

# Options
shutdown=''
reboot=''
lock=''
suspend='󰤄'
logout='󰗼'

# Actions
choice="$(echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi -dmenu -config ${dir}/config.rasi)"

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
