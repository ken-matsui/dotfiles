##################################
# Zsh Options
##################################

# Set operations.
setopt extended_glob
## Appends every command to the history file once it is executed
setopt inc_append_history
## Reloads the history whenever you use it
setopt share_history
# {a-d} expands to a b c d
setopt braceccl
# Remove all duplicates from history
setopt histignorealldups
# Ignore patterns such as URL
setopt nonomatch
## Don't highlight when selecting words
unset zle_bracketed_paste
