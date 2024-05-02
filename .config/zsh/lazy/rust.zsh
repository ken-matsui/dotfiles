if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
else
  export PATH="$PATH:$HOME/.cargo/bin"
fi
