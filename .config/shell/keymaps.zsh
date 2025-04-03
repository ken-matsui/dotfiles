bindkey -r '^['
bindkey '^V' vi-cmd-mode # default is ^[

# Enable bash-like key bindings
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^F' forward-word
bindkey '^B' backward-word

autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
