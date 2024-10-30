[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS="--height 12"
fi
