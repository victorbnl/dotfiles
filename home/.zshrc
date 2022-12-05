export PS1="%B%F{green}%n@%M %F{blue}%~ $%F{default}%b "

alias ls=ls-icons
alias list_user_installed_packages="comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq)"
