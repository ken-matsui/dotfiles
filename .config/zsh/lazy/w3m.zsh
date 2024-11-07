if (( $+commands[w3m] )); then
  export W3M_DIR="$XDG_DATA_HOME/w3m"
  alias w3m="w3m -config $XDG_CONFIG_HOME/w3m/config"
fi
