# Print a random, hopefully interesting, adage.
if (( $+commands[fortune] && $+commands[cowsay] && $+commands[lolcat] )); then
  fortune -s | cowsay -f small | lolcat -p 1.0
fi
