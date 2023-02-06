#!/bin/sh

PATH_PBAR="$HOME/.config/polybar"
GTK2FILE="$HOME/.gtkrc-2.0"
GTK3FILE="$HOME/.config/gtk-3.0/settings.ini"

to_dark() {
cat > ${PATH_PBAR}/colors.conf <<- EOF
[colors]
orange = #fbb86c
orange_highlight = #ffaf00
orange_text = #ffd7a1
blue = #6acad8
blue_highlight = #63b1bc
blue_text = #94ebeb
base_color = #2b2928
background = #33302f
selected = #94ebeb
transparent = #00000000
EOF
}

to_light() {
cat > ${PATH_PBAR}/colors.conf <<- EOF
[colors]
orange = #ffaf00
oragne_highlight = #fbb86c
orange_text = #af5c02
blue = #63b1bc
blue_highlight = #6acad8
blue_text = #00496d
base_color = #ffffff
background = #f6f6f6
selected = #63b1bc
transparent = #00000000
EOF
}

apply_appearance() {

	# apply gtk theme, icons, cursor & fonts
    if [[ $(cat $GTK3FILE | grep gtk-theme) == 'gtk-theme-name=Pop-dark' ]]; then
        theme="Pop"
        to_light
        notify-send Light
        cat ~/.config/rofi/pop.rasi > ~/.config/rofi/colors.rasi
    else
        theme="Pop-dark"
        to_dark
        notify-send Dark
        cat ~/.config/rofi/pop_dark.rasi > ~/.config/rofi/colors.rasi
    fi

	sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=\"$theme\"/g" ${GTK2FILE}
	#sed -i -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=\"$icon_theme\"/g" ${GTK2FILE}

	sed -ie "s/gtk-theme-name=.*/gtk-theme-name=$theme/g" ${GTK3FILE}
	#sed -i -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=$icon_theme/g" ${GTK3FILE}
}

apply_appearance &
bspc wm -r
