#!/bin/sh
source ~/.cache/wal/colors.sh
PATH_PBAR="$HOME/.config/polybar"
GTK2FILE="$HOME/.gtkrc-2.0"
GTK3FILE="$HOME/.config/gtk-3.0/settings.ini"

remove_Pywal() {
    sed -ie 's/cat/# cat/' ~/.config/fish/config.fish
}

Pywal_theme() {
cat ${PATH_PBAR}/Pywal_colors.conf > ${PATH_PBAR}/colors.conf
cat > ~/.config/rofi/colors.rasi <<- EOF
* {
    background:     ${color0};
    background-alt: ${color8};
    foreground:     ${color7};
    selected:       ${color3};
    active:         ${color2};
    urgent:         #FF5555FF;
}
EOF
}

Gruvbox_theme() {
cat > ${PATH_PBAR}/colors.conf <<- EOF
[colors]
color1 = #fb4934
color1_highlight = #fabd2f
color1_text = #ebdbb2
color2 = #665c54
color2_highlight = #a89984
color2_text = #8ec07c
base_color = #fbf1c7
background = #1d2021
selected = #d79921
transparent = #00000000
EOF
}

Dracula_theme() {
cat > ${PATH_PBAR}/colors.conf <<- EOF
[colors]
color1 = #50fa7b
color1_highlight = #8be9fd
color1_text = #f1fa8c
color2 = #6272a4
color2_highlight = #282a36
color2_text = #bd93f9
base_color = #44475a
background = #282a36
selected = #ffb86c
transparent = #00000000
EOF
}

Pop_dark() {
cat > ${PATH_PBAR}/colors.conf <<- EOF
[colors]
color1 = #fbb86c
color1_highlight = #ffaf00
color1_text = #ffd7a1
color2 = #6acad8
color2_highlight = #63b1bc
color2_text = #94ebeb
base_color = #2b2928
background = #33302f
selected = #94ebeb
transparent = #00000000
EOF
}

Pop() {
cat > ${PATH_PBAR}/colors.conf <<- EOF
[colors]
color1 = #ffaf00
oragne_highlight = #fbb86c
color1_text = #af5c02
color2 = #63b1bc
color2_highlight = #6acad8
color2_text = #00496d
base_color = #ffffff
background = #f6f6f6
selected = #63b1bc
transparent = #00000000
EOF
}

apply_appearance() {
	sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=\"$1\"/g" ${GTK2FILE}
	#sed -i -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=\"$icon_theme\"/g" ${GTK2FILE}

	sed -ie "s/gtk-theme-name=.*/gtk-theme-name=$1/g" ${GTK3FILE}
	#sed -i -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=$icon_theme/g" ${GTK3FILE}
}
# options to be displayed

options="Cancle
Pywal
Dracula-slim
Gruvbox-Dark-BL-LB
Pop
Pop-dark"

selected="$(echo -e "$options" | rofi -dmenu -i -p "Theme" \
          -config "~/.config/rofi/switch_theme/switch_theme.rasi" \
          -scrollbar-width "0")"

case $selected in
    Cancle)
        exit;;
    Pywal)
        wal -i "$(grep -m1 'file=' ~/.config/nitrogen/bg-saved.cfg | sed 's/file=//' | xargs echo -n)" -n    
        sed -ie 's/# cat/cat/' ~/.config/fish/config.fish   
        Pywal_theme;;
    Gruvbox-Dark-BL-LB)
        Gruvbox_theme
        remove_Pywal
        notify-send Gruvbox
        cat ~/.config/rofi/Gruvbox.rasi > ~/.config/rofi/colors.rasi
        apply_appearance $selected;;
    Dracula-slim)
        Dracula_theme
        remove_Pywal
        notify-send Dracula
        cat ~/.config/rofi/Dracula.rasi > ~/.config/rofi/colors.rasi
        apply_appearance $selected;;
    Pop)
        Pop
        notify-send Pop
        remove_Pywal
        cat ~/.config/rofi/pop.rasi > ~/.config/rofi/colors.rasi
        apply_appearance $selected;;
    Pop-dark)
        Pop_dark
        notify-send Pop_dark
        remove_Pywal
        cat ~/.config/rofi/pop_dark.rasi > ~/.config/rofi/colors.rasi
        apply_appearance $selected;;
esac

bspc wm -r
