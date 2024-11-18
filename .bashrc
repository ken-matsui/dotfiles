shopt -s nullglob dotglob
for conf in "$SHELL_CONFIG_HOME"/*.{sh,bash}; do source "$conf"; done
for conf in "$SHELL_CONFIG_HOME"/lazy/*.{sh,bash}; do source "$conf"; done
