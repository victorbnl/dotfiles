# Base commands
alias ls='eza'
alias grep='grep --color=auto'
alias ghc='ghc -dynamic'

# Remove pacman orphan dependencies
alias pacman-autoremove="pacman -Rs \$(pacman -Qdtq)"
# List pacman user-installed packages
alias pacman-user="comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq)"
