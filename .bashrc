# Source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

shopt -s nullglob dotglob
for conf in "$SHELL_CONFIG_HOME"/*.{sh,bash}; do source "$conf"; done
for conf in "$SHELL_CONFIG_HOME"/lazy/*.{sh,bash}; do source "$conf"; done
