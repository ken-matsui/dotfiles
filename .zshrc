# zmodload zsh/zprof  # for profiling

for conf in "$SH_CONFIG_HOME"/*.{sh,zsh}; do source "$conf"; done
for conf in "$SH_CONFIG_HOME"/after/*.{sh,zsh}; do source "$conf"; done
