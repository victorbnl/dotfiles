# Directories
dir="$HOME/.config/rofi/powermenu"

# Options
shutdown=''
reboot=''
lock=''
suspend='󰤄'
logout='󰗼'

# Actions
choice="$(echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi -dmenu -theme ${dir}/theme.rasi)"

case ${choice} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		echo "Locking"
    ~/.config/i3/lockscreen/lockscreen.sh
        ;;
    $suspend)
		echo "Suspending"
		systemctl suspend
        ;;
    $logout)
		echo "Logging out"
		i3-msg exit
        ;;
esac
