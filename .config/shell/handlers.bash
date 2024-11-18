command_not_found_handle() {
  if command_exists suggest-command-not-found; then
    exec suggest-command-not-found "$@"
  else
    echo "bash: command not found: $*"
  fi
}
