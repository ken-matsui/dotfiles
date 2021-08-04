##################################
# Homebrew settings
##################################

# Use this with the following command:
#   if (( $+commands[brew] )); then
#     source "$ZHOMEDIR/homebrew.zsh"
#   fi

HOMEBREW_PREFIX=$(brew --prefix)

eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# Completions
FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH
autoload -Uz compinit
compinit

# Openssl
export PATH="${HOMEBREW_PREFIX}/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/openssl@1.1/lib"
export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openssl@1.1/include"

# Google Cloud SDK (gcloud)
source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
