if (( $+commands[tmux] )); then
  export TMUX_PLUGIN_PATH="$XDG_CONFIG_HOME/tmux/plugins"

  tmux-window-name() {
    ($TMUX_PLUGIN_PATH/tmux-window-name/scripts/rename_session_windows.py &)
  }

  add-zsh-hook chpwd tmux-window-name
fi
