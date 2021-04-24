# Theme
ZSH_THEME="gentoo"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Plugins
plugins=(git)

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Oh My Zsh
export ZSH="/home/victor/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Tasks
alias t="task"
