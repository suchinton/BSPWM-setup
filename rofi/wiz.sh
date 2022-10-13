#!/bin/sh

# source the colors. from pywal
. "${HOME}/.cache/wal/colors.sh"

# options to be displayed
Select_wall="Select color"
wallpaper="Set from wallpaper"
turn_on="Turn on"
turn_off="Turn_off"
Cancle="[X]...Cancle"

options="$Cancle\n$wallpaper\n$Select_wall\n$turn_off\n$turn_on" 

selected="$(echo -e "$options" | rofi -dmenu -i -p "Wiz" \
          -config "~/.config/rofi/wiz.rasi" \
          -scrollbar-width "0")"

case $selected in
    $Cancle)
        echo "";;
    $wallpaper)
        code=$color3 ;;
    $Select_wall)
        code=$(xcolor) ;;
    $turn_off)
        echo '{"id":1,"method":"setState","params":{"state":false}}' | nc -u -w 1 192.168.29.237 38899 | echo 0;;
    $turn_on)
        echo '{"id":1,"method":"setState","params":{"state":true}}' | nc -u -w 1 192.168.29.237 38899 | echo 0;;
esac

hex2rgb() {
    hex=$(echo "${1^^}" | sed 's/#//g')

    a=$(echo $hex | cut -c-2)
    b=$(echo $hex | cut -c3-4)
    c=$(echo $hex | cut -c5-6)

    red=$(echo "ibase=16; $a" | bc)
    green=$(echo "ibase=16; $b" | bc)
    blue=$(echo "ibase=16; $c" | bc)
} 

hex2rgb ${code}

echo $red
echo $green
echo $blue

s1='{"id":1,"method":"setPilot","params":{"r":'

s2="${s1}${red},"
s2+='"g":'
s2+="${green},"
s2+='"b":'
s2+="${blue},"
s2+='"dimming":50}}'

echo $s2 | nc -u -w 1 192.168.29.237 38899 | echo 0
