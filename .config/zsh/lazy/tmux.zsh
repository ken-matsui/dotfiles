if (( $+commands[tmux] )); then
  export TMUX_PLUGIN_PATH="$XDG_CONFIG_HOME/tmux/plugins"

  if [[ -f "$TMUX_PLUGIN_PATH/tmux-window-name/scripts/rename_session_windows.py" ]]; then
    export TMUX_WINDOW_NAME_SCRIPT="$TMUX_PLUGIN_PATH/tmux-window-name/scripts/rename_session_windows.py"

    tmux-window-name() {
      ($TMUX_WONDOW_NAME_SCRIPT &)
    }
    add-zsh-hook chpwd tmux-window-name
  fi
fi
