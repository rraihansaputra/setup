HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
bindkey -e
zstyle :compinstall filename '/Users/rs/.zshrc'

autoload -Uz compinit
compinit



# # load antibody dynamically
# ANTIBODY_HOME="$(antibody home)"

# OMZ varibles
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

# # set OMZ directory on antibody
# export ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh

DISABLE_AUTO_UPDATE="true"

# # load antibody dynamically
# # TODO change antibody to load from setup dir.
# source <(antibody init)
# # load antibody plugins from .zsh_plugins.txt
# # this only loads when .zsh_plugins exist on source command dir
# # need to link it somehow..
# antibody bundle < ~/.zsh_plugins.txt

# zplug section

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
# insert omz for goodness
zplug "robbyrussell/oh-my-zsh"

# random plugins from antibody docs
zplug "djui/alias-tips"
zplug "caarlos0/zsh-mkc"

zplug "agkozak/zsh-z"

# zsh-users plugin
zplug "zsh-users/zsh-completions"

# zplug "zsh-users/zsh-autosuggestions"
if zplug check zsh-users/zsh-autosuggestions; then
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down) # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}") # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
fi
zplug "zsh-users/zsh-syntax-highlighting"

zplug "zsh-users/zsh-history-substring-search"
if zplug check zsh-users/zsh-history-substring-search; then
  bindkey "$terminfo[cuu1]" history-substring-search-up
  bindkey "$terminfo[cud1]" history-substring-search-down
fi

# omz plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/iterm2", from:oh-my-zsh
zplug "plugins/mosh", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/thefuck", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh

# uncomment for local theme dev
# somehow the bold is gone if i use local
# might be something with not using the OMZ path
# zplug "/Users/rs/setup/zsh-plugins", as:theme, from:local, use:"re5et-rs.zsh-theme"
zplug "rraihansaputra/setup", as:theme, use:"zsh-plugins/re5et-rs.zsh-theme"
# zplug "rraihansaputra/setup", path:/zsh-plugins/re5et-rs.zsh-theme, as:theme


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load # --verbose

# avoid language woes
export LANG=en_US.UTF-8

# java version configs
# export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
# export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
# export JAVA_12_HOME=$(/usr/libexec/java_home -v12)

# alias java8='export JAVA_HOME=$JAVA_8_HOME'
# alias java11='export JAVA_HOME=$JAVA_11_HOME'
# alias java12='export JAVA_HOME=$JAVA_12_HOME'

# default to java11 for armillary/taiger
# java11

# android dev vars
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home"
export ANDROID_HOME="/Users/rs/Library/Android/sdk"
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/28.0.3

# default openssh to brew
export LDFLAGS="-I/usr/local/opt/openssl@1.1/include -L/usr/local/opt/openssl@1.1/lib"

# add brew openssh to PATH
export OPENSSL_PATH="/usr/local/opt/openssl@1.1/bin"
export PATH=$OPENSSL_PATH:$PATH

# personal aliases
# alias vsc=/usr/local/bin/vsc
# alias code=/usr/local/bin/code

# init rbenv
eval "$(rbenv init -)"

alias glb="git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep 'checkout:' | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | head -n 10 | awk -F' ~ HEAD@{' '{printf(\"  \\033[33m%s: \\033[37m %s\\033[0m\\n\", substr($2, 1, length($2)-1), $1)}'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/Users/rs/Library/Python/3.9/bin:$PATH"
