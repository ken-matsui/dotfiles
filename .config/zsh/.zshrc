#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Set operation.
setopt EXTENDED_GLOB

## Warning setting for tensorflow.
export TF_CPP_MIN_LOG_LEVEL=2

# awscli
if [[ -d ~/.aws ]]; then
    export AWS_DEFAULT_REGION=$(cat ~/.aws/config | grep 'region' | awk '{printf $3}')
    export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials | grep 'aws_access_key_id' | awk '{printf $3}')
    export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials | grep 'aws_secret_access_key' | awk '{printf $3}')
fi

# coreutils
#export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# gnu-tar
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
alias tar=gtar

# rust
source $HOME/.cargo/env

# nvim
alias vim=nvim
export XDG_CONFIG_HOME=$HOME/.config

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/erlang@20/bin:$PATH"

# Don't highlight when selecting words
unset zle_bracketed_paste

# Enable zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable safety dumping
alias rm='gmv -f --backup=numbered --target-directory ~/.Trash/'

# added by travis gem
[ -f /Users/matken/.travis/travis.sh ] && source /Users/matken/.travis/travis.sh

# flutter
export PATH="$HOME/flutter/bin:$PATH"

# golang with app-engine by Google
export PATH="$PATH:$HOME/.go_appengine"
# gcloud command
export CLOUDSDK_PYTHON=python3

# clangd
#export PATH="/usr/local/opt/llvm/bin:$PATH"

# Added by Krypton
export GPG_TTY=$(tty)

# .gitignore generator
function gi() {
    curl -fsSL https://www.gitignore.io/api/$@ >>! $PWD/.gitignore && echo "overwrote $@ to $PWD/.gitignore"
}

# After adding .gitignore, ignore files
function gigafter() {
    git rm --cached $(git ls-files --full-name -i --exclude-standard)
}

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
