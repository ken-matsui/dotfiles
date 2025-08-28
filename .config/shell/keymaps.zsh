# Use Emacs key bindings
bindkey -e
# NOTE: '^X^V' vi-cmd-mode

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word

# Edit the current command line in $VISUAL (or $EDITOR / `vi` if not set)
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# File rename magick (Alt+m or Esc m)
bindkey '^[m' copy-prev-shell-word
