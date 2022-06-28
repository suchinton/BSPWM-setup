#!/bin/bash

# options to be displayed
option0="  ... Screen"
option1="  ... Area"
option2="  ... Window"

# options to be displyed
options="$option0\n$option1\n$option2"

selected="$(echo -e "$options" | rofi -lines 3 -dmenu -p "screen-shot" -config "~/.config/rofi/powermenu.rasi")"
case $selected in
    $option0)
        flameshot screen -p ~/Pictures/ ;;
    $option1)
        flameshot gui -p ~/Pictures/ ;;
    $option2)
        cd ~/Pictures/ && sleep 1 && scrot -u;;
esac

