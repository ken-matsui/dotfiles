if (( $+commands[atuin] )); then
  eval "$(atuin init zsh --disable-up-arrow)"

  _zsh_autosuggest_strategy_atuin_top() {
    suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
  }
  ZSH_AUTOSUGGEST_STRATEGY=atuin_top
fi
