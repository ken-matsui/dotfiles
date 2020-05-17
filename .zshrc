export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "modules/directory", from:prezto
zplug "modules/completion", from:prezto
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [Y/n]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

# Set operation.
setopt EXTENDED_GLOB
# Don't highlight when selecting words
unset zle_bracketed_paste

##################################
# Environment Paths
##################################
export XDG_CONFIG_HOME=$HOME/.config
#export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # coreutils
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH" # gnu-tar
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH" # flutter
export PATH="$PATH:$HOME/.go_appengine" # golang with app-engine by Google

##################################
# Environment Variables
##################################
if [[ -d ~/.aws ]]; then # awscli
    export AWS_DEFAULT_REGION=$(cat ~/.aws/config | grep 'region' | awk '{printf $3}')
    export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials | grep 'aws_access_key_id' | awk '{printf $3}')
    export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials | grep 'aws_secret_access_key' | awk '{printf $3}')
fi
export CLOUDSDK_PYTHON=python3 # gcloud command
export TF_CPP_MIN_LOG_LEVEL=2 # Warning setting for tensorflow.
export GPG_TTY=$(tty) # Added by Krypton

##################################
# Aliases
##################################
alias tar=gtar
alias vim=nvim
alias rm='gmv -f --backup=numbered --target-directory ~/.Trash/' # Enable safety dumping

##################################
# Software evaluations
##################################
source $HOME/.cargo/env # rust
eval "$(starship init zsh)" # starship
[ -f /Users/matken/.travis/travis.sh ] && source /Users/matken/.travis/travis.sh # added by travis gem

##################################
# Functions
##################################
# .gitignore generator
function gi() {
    curl -fsSL https://www.gitignore.io/api/$@ >>! $PWD/.gitignore && echo "overwrote $@ to $PWD/.gitignore"
}
# After adding .gitignore, ignore files
function gigafter() {
    git rm --cached $(git ls-files --full-name -i --exclude-standard)
}
