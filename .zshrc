##################################
# .zshrc
##################################

if (( $+commands[brew] )); then
  source "$ZHOMEDIR/homebrew.zsh"
fi
source "$ZHOMEDIR/zplug.zsh"
source "$ZHOMEDIR/option.zsh"
source "$ZHOMEDIR/bindkey.zsh"
source "$ZHOMEDIR/alias.zsh"
source "$ZHOMEDIR/function.zsh"

# Software Config
for config in $ZHOMEDIR/software_config/**/*(.); do source $config; done
