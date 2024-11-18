#
# Environment Variables
#

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export SHELL_CONFIG_HOME="$XDG_CONFIG_HOME/shell"
export SHELL_NAME="${SHELL##*/}"

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
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

#
# Homebrew
#
if [ -f /opt/homebrew/bin/brew ]; then
  # M1
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  # Linux
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f ~/homebrew/bin/brew ]; then
  # Home directory installation
  eval "$(~/homebrew/bin/brew shellenv)"
fi
if command -v brew >/dev/null 2>&1; then
  export HOMEBREW_PREFIX="$(brew --prefix)"
fi
