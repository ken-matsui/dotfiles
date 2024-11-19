#!/usr/bin/env sh

if command_exists atuin; then
  if is_bash_or_zsh "$0"; then
    eval "$(atuin init "$SHELL_NAME" --disable-up-arrow)"
  else
    return 1
  fi

  if [ "$SHELL_NAME" != 'zsh' ]; then
    return 0
  fi

  _zsh_autosuggest_strategy_atuin_top() {
    suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix "$1")
  }
  ZSH_AUTOSUGGEST_STRATEGY=atuin_top

  # Incognito mode
  # Usage: incognito [disable|d]
  incognito() {
    if [ "$1" = 'disable' ] || [ "$1" = 'd' ]; then
        add-zsh-hook precmd _atuin_precmd
        add-zsh-hook preexec _atuin_preexec
        unset ATUIN_INCOGNITO
    else
        add-zsh-hook -d precmd _atuin_precmd
        add-zsh-hook -d preexec _atuin_preexec
        export ATUIN_INCOGNITO=1
    fi
  }
fi
