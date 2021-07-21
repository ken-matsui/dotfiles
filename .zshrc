export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "modules/directory", from:prezto
zplug "modules/completion", from:prezto
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "so-fancy/diff-so-fancy", as:command

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [Y/n]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Set operations.
setopt EXTENDED_GLOB
## Appends every command to the history file once it is executed
setopt inc_append_history
## Reloads the history whenever you use it
setopt share_history
# {a-d} expands to a b c d
setopt braceccl
## Don't highlight when selecting words
unset zle_bracketed_paste

##################################
# Zsh Key Binds
##################################
# Reset key binds
bindkey -d
# Remove default key binds
for KEY in {A-Z}; do bindkey -r "^$KEY"; done
# Restore some default key binds
bindkey '^M' accept-line # for enter key
bindkey '^I' expand-or-complete # for tab key
bindkey '^U' vi-kill-line
# Enable bash like key binds
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

##################################
# Environment Paths
##################################
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export PATH="$HOME/flutter/bin:$PATH" # flutter
export PATH="$HOME/.cargo/bin:$PATH"  # rust
export PATH="$HOME/.poetry/bin:$PATH" # poetry
# openssl
HOMEBREW_PREFIX=$(brew --prefix)
export PATH="${HOMEBREW_PREFIX}/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/openssl@1.1/lib"
export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openssl@1.1/include"

##################################
# Environment Variables
##################################
if [[ -d ~/.aws ]]; then # awscli
    export AWS_DEFAULT_REGION=$(cat ~/.aws/config | grep 'region' | awk '{printf $3}')
    export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials | grep 'aws_access_key_id' | awk '{printf $3}')
    export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials | grep 'aws_secret_access_key' | awk '{printf $3}')
fi
export TF_CPP_MIN_LOG_LEVEL=2 # Warning setting for tensorflow.
export GPG_TTY=$(tty) # Added by Krypton

##################################
# Aliases
##################################
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi
# Enable safety dumping
alias rm='gmv -f --backup=numbered --target-directory ~/.Trash'
# After adding .gitignore, ignore files
alias gigafter='git rm --cached $(git ls-files --full-name -i --exclude-standard)'
alias deletedocker='docker ps -aq | xargs docker rm && docker images -aq | xargs docker rmi'
alias ls=exa
alias node14='/usr/local/opt/node@14/bin/node'
alias npm14='/usr/local/opt/node@14/bin/npm'
alias npx14='/usr/local/opt/node@14/bin/npx'

##################################
# Functions
##################################
# .gitignore generator
function gi() { curl -fsSL https://www.gitignore.io/api/$@ >>! $PWD/.gitignore && echo "added $@ to $PWD/.gitignore" }
# Replace strings recursively (example: $ replace ./ hey hello)
function replace() { find $1 -type f -print0 | xargs -0 sed -i '' -e "s/$2/$3/g" }
function sizeof() { du -sh "$@" }

##################################
# Software evaluations
##################################
eval "$(starship init zsh)" # starship
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# Google Cloud SDK (gcloud)
source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

