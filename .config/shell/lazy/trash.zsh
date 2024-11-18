if [[ "$OSTYPE" == darwin* && $+commands[trash] -eq 1 ]]; then
  alias rm='trash'
fi
