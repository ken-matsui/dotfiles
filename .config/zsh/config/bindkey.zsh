##################################
# Key Bindings
##################################

# Reset key binds
bindkey -d
# Remove default key binds
for KEY in {A-Z}; do bindkey -r "^$KEY"; done
# Restore some default key binds
bindkey '^M' accept-line # for enter key
bindkey '^I' expand-or-complete # for tab key
bindkey '^U' vi-kill-line
# Restore some key binds with other keys
bindkey "^B" clear-screen # default is ^L
# Enable bash like key binds
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
