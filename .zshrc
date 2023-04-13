##################################
# .zshrc
##################################

# zmodload zsh/zprof  # for profiling
for config in $ZDOT_HOME/config/**/*.zsh; do source $config; done
for config in $ZDOT_HOME/software_config/**/*.zsh; do source $config; done
