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

PROMPT='
%{$fg[cyan]%}%n%{$reset_color%}%{$fg[yellow]%}@%{$reset_color%}%{$fg[blue]%}%m%{$reset_color%}:%{${fg[green]}%}%~%{$reset_color%}$(git_prompt_info_with_last_commit_message)
%{${fg[$CARETCOLOR]}%}%# %{${reset_color}%}'

RPS1='${return_code} %D - %*'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}^%{$reset_color%}%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} pls commit"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ok"
