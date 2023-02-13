# Plugins
source ~/.zsh-plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Command prompt
export PS1="%B%F{green}%n@%M %F{blue}%~ $%F{default}%b "

# Aliases
alias ls="ls --color"
alias list_user_installed_packages="comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq)"
alias matrix="unimatrix -n -s 96 -l o"

# Emacs keybinding (most importantly CTRL+A behaviour)
bindkey -e

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
