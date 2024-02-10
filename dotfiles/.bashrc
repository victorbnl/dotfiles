# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Command prompt
export PS1='\[\e[1;32m\]\u@\H \[\e[1;34m\]\w \$\[\e[m\] '

# Aliases
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Load ~/.profile
. $HOME/.profile
