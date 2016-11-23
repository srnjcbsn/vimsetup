# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 4
zstyle :compinstall filename '/home/sja/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
# bindkey -v
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:*' actionformats \
'%F{2}%b%f'
zstyle ':vcs_info:*' formats       \
'%F{2}%b%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd() {
    vcs_info
}


setopt prompt_subst
PROMPT="%1{%(0?.%F{green}●%f.%F{red}●%f)%} %{%F{blue}%}%~%{%f%} "
RPROMPT='${vcs_info_msg_0_}'

alias grep='grep --color=always'
alias ll='ls -lh --color=auto'
alias s='apt search'
alias i='sudo apt install -y'

u () {
    args=($@)
    eval "$@"
    succ=$?
    echo "\a"
    if [[ $succ > 0 ]]; then
        notify-send "Failed: $args"
    else
        notify-send "Finished: $args"
    fi
}

source "/usr/share/zgen/zgen.zsh"
if ! zgen saved; then

    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-history-substring-search

    zgen save
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=magenta,bold'
