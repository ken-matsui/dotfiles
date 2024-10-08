if (( $+commands[xsel] )); then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'

  if (( $+commands[tmux] )); then
    tmux set -s copy-command 'xsel --clipboard --input'
  fi
fi
