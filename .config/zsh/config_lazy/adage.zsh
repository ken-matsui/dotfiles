# Print a random, hopefully interesting, adage.
if (( $+commands[fortune] && $+commands[cowsay] )); then
  ADAGE="$(fortune -s | cowsay -f small)"
  if (( $+commands[lolcat] )); then
    [ $(($RANDOM % 10)) -eq 1 ] && echo $ADAGE | lolcat -p 1.0 || echo $ADAGE
  else
    echo "$ADAGE"
  fi
fi
