HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
bindkey -e
zstyle :compinstall filename '/Users/rs/.zshrc'

autoload -Uz compinit
compinit

# load antibody dynamically
ANTIBODY_HOME="$(antibody home)"

# OMZ varibles
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

# set OMZ directory on antibody
export ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh

DISABLE_AUTO_UPDATE="true"

# load antibody dynamically
source <(antibody init)
# load antibody plugins from .zsh_plugins.txt
# this only loads when .zsh_plugins exist on source command dir
# need to link it somehow..
antibody bundle < .zsh_plugins.txt

# avoid language woes
export LANG=en_US.UTF-8

# personal aliases
alias code=vscodium
