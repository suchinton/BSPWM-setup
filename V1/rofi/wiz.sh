#!/bin/sh

# source the colors. from pywal
. "${HOME}/.cache/wal/colors.sh"

IP=192.168.29.237

hex2rgb() 
{
    hex=$(echo "${1^^}" | sed 's/#//g')

    a=$(echo $hex | cut -c-2)
    b=$(echo $hex | cut -c3-4)
    c=$(echo $hex | cut -c5-6)

    red=$(echo "ibase=16; $a" | bc)
    green=$(echo "ibase=16; $b" | bc)
    blue=$(echo "ibase=16; $c" | bc)
    brightness=50
    echo not given $brightness
} 

rgb() 
{
    pat=[',','(',')','rgb','rgba']
    code=$(echo $code | tr $pat "\n")
    colors=()
    i=0
    for range in $code
    do
        colors[$i]=$range
        let "i+=1"
    done
    echo $colors 
    red=${colors[0]}
    green=${colors[1]}
    blue=${colors[2]}
} 

# options to be displayed
Select_wall="Select color"
wallpaper="Set from wallpaper"
Shuffle="Shuffle from wallpaper"
turn_on="Turn on"
turn_off="Turn_off"
Cancle="[X]...Cancle"

options="$Cancle\n$wallpaper\n$Select_wall\n$Shuffle\n$turn_off\n$turn_on" 

selected="$(echo -e "$options" | rofi -dmenu -i -p "Wiz" \
          -config "~/.config/rofi/wiz.rasi" \
          -scrollbar-width "0")"

shuffle()
{
    palet=(
           $color1 \
           $color2 \
           $color3 \
           $color4 \
           $color5 \
           $color6 \
           $color7 )
    while :
    do 
        for i in ${palet[@]}
        do
            echo $i
            hex2rgb ${i}
            
            echo $red
            echo $green
            echo $blue

            s1='{"id":1,"method":"setPilot","params":{"r":'

            s2="${s1}${red},"
            s2+='"g":'
            s2+="${green},"
            s2+='"b":'
            s2+="${blue}}}"

            echo $s2 | nc -u -w 1 192.168.29.237 38899 | echo 0
            sleep 1
        done
    done
}

case $selected in
    $Cancle)
        echo "";;
    $wallpaper)
        code=$color3
        hex2rgb ${code};;
    $Select_wall)
        code=$(zenity --color-selection) 
        echo $code
        rgb ${code};;
    $Shuffle)
        echo hello
        shuffle ${code};;
    $turn_off)
        echo '{"id":1,"method":"setState","params":{"state":false}}' | nc -u -w 1 $IP 38899 | echo 0;;
    $turn_on)
        echo '{"id":1,"method":"setState","params":{"state":true}}' | nc -u -w 1 $IP 38899 | echo 0;;
esac

echo $red
echo $green
echo $blue
echo $brightness

s1='{"id":1,"method":"setPilot","params":{"r":'

s2="${s1}${red},"
s2+='"g":'
s2+="${green},"
s2+='"b":'
s2+="${blue}}}"

echo $s2 | nc -u -w 1 $IP 38899 | echo 0
