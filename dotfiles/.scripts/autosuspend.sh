#!/usr/bin/env bash

export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 300 \
    'echo $(dunstify -p "Going to sleep") > ~/.cache/sleep_notification_id' \
    'dunstify -C $(cat ~/.cache/sleep_notification_id)' \
  --timer 10 \
    '~/.scripts/open.sh lockscreen' \
    '' \
  --timer 300 \
    'systemctl suspend' \
    ''
