# Print a random, hopefully interesting, adage.
if (( $+commands[fortune] && $+commands[cowsay] )); then
  fortune -s | cowsay -f small
fi
