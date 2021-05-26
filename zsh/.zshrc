# Path
export PATH="$PATH:~/.local/bin:/home/victor/.local/share/gem/ruby/3.0.0/bin"

# Prompt
export PS1=$'%B\033[32m%n@%M \033[34m%~ $\033[0m%b '

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

# Tasks
alias t="task"

# youtube-dl
alias ytdl="youtube-dl"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/.local/bin"

# Start pyenv
eval "$(pyenv init -)"
