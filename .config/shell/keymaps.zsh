# Use Emacs key bindings
bindkey -e
# NOTE: '^X^V' vi-cmd-mode

autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
