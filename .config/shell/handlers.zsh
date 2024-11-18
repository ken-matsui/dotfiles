command_not_found_handler() {
  if command_exists suggest-command-not-found; then
    exec suggest-command-not-found "$@"
  else
    echo "zsh: command not found: $*"
  fi
}
