if (( $+commands[brew] )); then
  # Completions
  FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
  compaudit # in case we receive warnings on compinit; to fix on macOS, chmod -R go-w $DIR

  # Local variable
  HOMEBREW_PREFIX=$(brew --prefix)
fi
