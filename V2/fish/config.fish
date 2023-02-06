if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
neofetch --ascii_distro popos_small

cat ~/.cache/wal/sequences

alias set_flatpak_theme='sudo flatpak override --filesystem=$HOME/.themes & read name & sudo flatpak override --env=GTK_THEME=$name'

#switch between bash and zsh and fish
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

#fix obvious typo's
alias cd..='cd ..'
alias pdw="pwd"

#alias to get to /home/suchinton/
alias home='cd $HOME'

#alias to repair pacman after time-shift (pacman currently in use)
alias repair-pacman "sudo rm /var/lib/pacman/db.lck"
