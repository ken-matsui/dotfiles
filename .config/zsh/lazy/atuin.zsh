if (( $+commands[atuin] )); then
  eval "$(atuin init zsh --disable-up-arrow)"

  _zsh_autosuggest_strategy_atuin_top() {
    suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
  }
  ZSH_AUTOSUGGEST_STRATEGY=atuin_top

  # incognito mode
  incognito () {
    if [[ $1 = disable ]] || [[ $1 == d ]]; then
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
