##################################
# Environment Variables
##################################

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export ZDOT_ROOT=$HOME
export ZDOT_HOME=$ZDOT_ROOT/.config/zsh

#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'

#
# Locale
#
export LANG="${LANG:-en_US.UTF-8}"
export LANGUAGE="${LANGUAGE:-en_US}"
export LC_ALL="${LC_ALL:-$LANG}"
export TZ='America/New_York'

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Homebrew
#
# At this time, the `brew` command is unavailable; we need to find the
# excutable instead of `$+commands[brew]`.
if [ -f /opt/homebrew/bin/brew ]; then
  # M1
  eval "$(/opt/homebrew/bin/brew shellenv)"
  HOMEBREW_PREFIX=$(brew --prefix)
elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  # Linux
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  HOMEBREW_PREFIX=$(brew --prefix)
elif [ -f ~/homebrew/bin/brew ]; then
  # Home directory installation
  eval "$(~/homebrew/bin/brew shellenv)"
  HOMEBREW_PREFIX=$(brew --prefix)
fi
