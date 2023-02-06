#!/bin/sh

roficonfig="$HOME/.config/rofi/music/music.rasi"
Control="MPD"
[ -n "$(pgrep spotify)" ] && Control="spotify"
musicmetadata() {

player=""

title=$(playerctl --player=$Control metadata --format {{title}} | cut -c1-35)
title=${title:-Play Something}

artist=$(playerctl --player=$Control metadata --format {{artist}} | cut -c1-35)
artist=${artist:-Artist}

album=$(playerctl --player=$Control metadata --format {{album}} | cut -c1-35)
album=${album:-Album}

status=$(playerctl --player=$Control status)
status=${status:-Stopped}

icon="ﭥ"
[ "$status" = "Playing" ] && icon=""
[ "$status" = "Paused" ] && icon="喇"

playlist=$(playerctl --player=$Control metadata xesam:trackNumber)
playlist=${playlist:-0}
}

musicmetadata
echo $Control

## Rofi stuff
previous="玲"
next="怜"
options="$player\n$previous\n$icon\n$next\n$lyrics"

rofi=$(printf $options | rofi -config $roficonfig -dmenu -i -selected-row 2 -hover-select -p "$status: ($playlist)
$title
$album
$artist")

case $rofi in
		$player)	wmctrl -a $Control || flatpak run com.spotify.Client ;;
		$next)		playerctl --player=$Control next            ;;
		$icon)		playerctl --player=$Control play-pause      ;;
		$previous)	playerctl --player=$Control previous      ;;
esac
