# For Zsh
command_not_found_handler() {
  if command -v suggest-command-not-found &> /dev/null; then
    exec suggest-command-not-found $@
  else
    echo "zsh: command not found: $@"
  fi
}

# For Bash
command_not_found_handle() {
  if command -v suggest-command-not-found &> /dev/null; then
    exec suggest-command-not-found $@
  else
    echo "bash: command not found: $@"
  fi
}
