#!/bin/env bash

# options to be displayed
Performance="異  ...Performance"
Balanced="  ...Balanced"
Powersaver="  ...Power-saver"
Cancle="[X]...Cancle"

options="$Cancle\n$Performance\n$Balanced\n$Powersaver"

selected="$(echo -e "$options" | rofi -dmenu -i -p "P-Profile" \
          -config "~/.config/rofi/power-profiles/power-profiles.rasi" \
          -scrollbar-width "0")"

case $selected in
    $Cancle)
        echo "";;
    $Performance)
        powerprofilesctl set performance ;;
    $Balanced)
        powerprofilesctl set balanced ;;
    $Powersaver)
        powerprofilesctl set power-saver ;;
esac
