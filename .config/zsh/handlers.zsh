command_not_found_handler() {
  if command -v suggest-command-not-found &> /dev/null; then
    exec suggest-command-not-found $@
  else
    echo "zsh: command not found: $@"
  fi
}
