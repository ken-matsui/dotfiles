##################################
# .zshrc
##################################

for config in $ZHOMEDIR/config/**/*.zsh; do source $config; done
for config in $ZHOMEDIR/software_config/**/*.zsh; do source $config; done
for config in $ZHOMEDIR/config_lazy/**/*.zsh; do source $config; done
