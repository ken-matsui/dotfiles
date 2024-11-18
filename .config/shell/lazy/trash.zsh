if [[ "$(uname)" == Darwin && $+commands[trash] -eq 1 ]]; then
  alias rm='trash'
fi
