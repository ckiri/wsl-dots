# load version control information
autoload -Uz vcs_info

# enable the version-control variable & format it
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'

# define the precmd hook function
precmd() {
    vcs_info # show version controll information e.g. branch-name
    print -Pn "\e]0;%n@%m in %/\a" # show shell-session information on window title
}

# check if connected via ssh
checkssh() {
    if test -n "$SSH_CLIENT"
    then
        print "%BSSH%b "
    fi
}

# prompt configuration
setopt PROMPT_SUBST
PROMPT='$(checkssh)%3~${vcs_info_msg_0_}%(?.. E:%?) %# '

# shell history configuration
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY # share history between sessions
HISTFILE=~/.cache/zsh/history # history cache directory

# tab-completion
autoload -U compinit
zstyle ':completion:*' menu select 
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# keymaps
bindkey -v # vi-mode
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Loads FZF keybindings, replacing native reverse search etc with FZF
#test -f ~/.fzf.zsh \
#    && source ~/.fzf.zsh

# Set options for FZF
export FZF_DEFAULT_OPTS="
--ansi
--layout=reverse
--no-color
--no-unicode
--no-scrollbar
--no-bold
--height=25
--pointer=' '
--marker=' '
"

open-explorer() {
    explorer.exe .
}

zle -N open-explorer

bindkey '^O' open-explorer

fzf-bind-history() {
  BUFFER=$(history -n; history | fzf)
  CURSOR=$#BUFFER
}

zle -N fzf-bind-history

bindkey '^R' fzf-bind-history

alias vim="nvim"
