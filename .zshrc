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
# TODO change antibody to load from setup dir.
source <(antibody init)
# load antibody plugins from .zsh_plugins.txt
# this only loads when .zsh_plugins exist on source command dir
# need to link it somehow..
antibody bundle < ~/.zsh_plugins.txt

# avoid language woes
export LANG=en_US.UTF-8

# java version configs
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
export JAVA_12_HOME=$(/usr/libexec/java_home -v12)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java12='export JAVA_HOME=$JAVA_12_HOME'

# default to java11 for armillary/taiger
java11

# android dev vars
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home"
export ANDROID_HOME="/Users/rs/Library/Android/sdk"
#export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/28.0.3

# default openssh to brew
export LDFLAGS="-I/usr/local/opt/openssl@1.1/include -L/usr/local/opt/openssl@1.1/lib"

# add brew openssh to PATH
export OPENSSL_PATH="/usr/local/opt/openssl@1.1/bin"
export PATH=$OPENSSL_PATH:$PATH

# personal aliases
alias vsc=/usr/local/bin/code
alias code=vscodium
