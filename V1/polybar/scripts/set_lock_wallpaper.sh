#!/bin/sh

## wallpaper to sddm sugar background
if zenity --question --text="Do you want to Apply wallpaper to login page?"
then 
    wall=$(grep -m1 'file=' ./.config/nitrogen/bg-saved.cfg | sed 's/file=//' | xargs echo -n) && pkexec cp $wall -r /usr/share/sddm/themes/sugar-candy/Backgrounds/Background.png &
fi
