##################################
# .zshrc
##################################

# zmodload zsh/zprof  # for profiling
for config in $ZDOT_HOME/*.zsh; do source $config; done
for config in $ZDOT_HOME/lazy/*.zsh; do source $config; done
