#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Set operation.
setopt EXTENDED_GLOB

# A function that displays the name of the
#  virtual environment at the right prompt.
function cd {
	builtin cd "$@"
	if [[ -e .python-version ]]; then
		RPROMPT="%F{red}(`cat .python-version`)%f"
		typeset -g pv_dir=${PWD:1}
	elif [[ -v pv_dir ]] && [[ `pwd` =~ ${pv_dir} ]]; then
		unset MATCH
	else
		RPROMPT=""
	fi
}

# anyenv
if [[ -d $HOME/.anyenv ]] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init - --no-rehash)"
fi

## Warning setting of tensorflow.
export TF_CPP_MIN_LOG_LEVEL=2

# golang with app-engine by Google
export PATH="$PATH:$HOME/.go_appengine"
# gcloudのバグ対策
export CLOUDSDK_PYTHON='/Users/matken/.pyenv/versions/2.7.14/bin/python2'

# tmux_automatically_attach attachs tmux session
# automatically when your are in zsh
TMUXX_DIR=$(dirname $(dirname $(readlink ../.zshrc)))/scripts
[[ -x $TMUXX_DIR/tmuxx.sh ]] && $TMUXX_DIR/tmuxx.sh

