# History configuration
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
bindkey -e

# Oh My Zsh settings
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
DISABLE_AUTO_UPDATE="true"

# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

export LANG=en_US.UTF-8
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="$PATH:/Users/rs/.local/bin"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export ANDROID_HOME="/Users/rs/Library/Android/sdk"
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/28.0.3
export LDFLAGS="-I/usr/local/opt/openssl@1.1/include -L/usr/local/opt/openssl@1.1/lib"
export OPENSSL_PATH="/usr/local/opt/openssl@1.1/bin"
export PATH=$OPENSSL_PATH:$PATH


# Load core plugins
zinit wait lucid for \
    djui/alias-tips \
    caarlos0/zsh-mkc \
    agkozak/zsh-z

zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZL::git.zsh

zinit wait lucid for \
    OMZP::git \
    OMZL::functions.zsh \
    OMZL::completion.zsh

# Development tool plugins
zinit wait lucid for \
    OMZP::asdf \
    redxtech/zsh-asdf-direnv

zinit wait"1" lucid for \
    OMZP::colored-man-pages \
    OMZP::colorize \
    OMZP::iterm2 \
    OMZP::mosh \
    OMZP::thefuck \
    OMZP::tmux \
    # OMZP::macos \

# Custom aliases
alias glb="git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep 'checkout:' | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | head -n 10 | awk -F' ~ HEAD@{' '{printf(\"  \\033[33m%s: \\033[37m %s\\033[0m\\n\", substr($2, 1, length($2)-1), $1)}'"

# Tool initializations (fixed quotes)
zinit wait"2" lucid as"null" for \
    atload'[ -s "/Users/rs/.bun/_bun" ] && source "/Users/rs/.bun/_bun"' \
    atload'[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' \
    atload'. ~/.asdf/plugins/golang/set-env.zsh' \
    atload'eval "$(uv generate-shell-completion zsh)"' \
    atload'eval "$(uvx --generate-shell-completion zsh)"' \
    zdharma-continuum/null

# History and search plugins
zinit wait lucid for \
  zdharma-continuum/history-search-multi-word \
  joshskidmore/zsh-fzf-history-search

# Load fzf-tab with configuration
zinit wait lucid for \
  Aloxaf/fzf-tab

# fzf-tab configuration
zinit ice wait lucid atload"
    zstyle ':completion:*:git-checkout:*' sort false
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
    zstyle ':fzf-tab:*' switch-group ',' '.'
    zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
        fzf-preview 'echo ${(P)word}'
    zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
        'git diff $word | delta'
    zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
        'git log --color=always $word'
    zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
        'git help $word | bat -plman --color=always'
    zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
        'case "$group" in
        "commit tag") git show --color=always $word ;;
        *) git show --color=always $word | delta ;;
        esac'
    zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
        'case "$group" in
        "modified file") git diff $word | delta ;;
        "recent commit object name") git show --color=always $word | delta ;;
        *) git log --color=always --pretty="%Cgreen %ar %Cred%h %Creset%an %n  %s" $word ;;
        esac'
    zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
"

# Completions and syntax highlighting
zinit wait lucid for \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting

# Lazy load conda
conda() {
  unfunction conda
  __conda_setup="$("/opt/miniconda3/bin/conda" "shell.zsh" "hook" 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/opt/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="/opt/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  conda "$@"
}


####
# re5et-rs theme
function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref#refs/heads/}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

function parse_git_dirty() {
  local STATUS
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(__git_prompt_git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ "${DISABLE_UNTRACKED_FILES_DIRTY}" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(__git_prompt_git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

function git_commit_message() {
    local COMMIT_MSG
    COMMIT_MSG=$(__git_prompt_git log -1 --oneline 2> /dev/null) && echo "%{$reset_color%}
%{$fg[yellow]%}$COMMIT_MSG%{$reset_color%}"
}

function git_prompt_info_with_last_commit_message() {
    echo "$(git_prompt_info)$(git_commit_message)"
}

if [ "$USER" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="green"; fi

local return_code="%(?..%{$fg_bold[red]%}:( %?%{$reset_color%})"

# Add this function to format directory paths
function formatted_path() {
    local p=${PWD/#$HOME/\~}  # Replace $HOME with ~

    # For ~/Projects path
    if [[ $p == "~/Projects"* ]]; then
        # p=${p/#\~\/Projects/※}  # Replace ~/Projects with ※
        p=${p/#\~\/Projects/👨‍🍳}  # Replace ~/Projects with ※
    fi

    echo $p
}

# Update your PROMPT to use formatted_path and clean machine name
PROMPT='
%{$fg[cyan]%}%n%{$reset_color%}%{$fg[yellow]%}@%{$reset_color%}%{$fg[blue]%}a%{$reset_color%}:%{${fg[green]}%}$(formatted_path)%{$reset_color%}$(git_prompt_info_with_last_commit_message)
%{${fg[$CARETCOLOR]}%}%# %{${reset_color}%}'
# PROMPT='
# %{$fg[cyan]%}%n%{$reset_color%}%{$fg[yellow]%}@%{$reset_color%}%{$fg[blue]%}%m%{$reset_color%}:%{${fg[green]}%}%~%{$reset_color%}$(git_prompt_info_with_last_commit_message)
# %{${fg[$CARETCOLOR]}%}%# %{${reset_color}%}'

RPS1='${return_code} %D - %*'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}^%{$reset_color%}%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} pls commit"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ok"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
