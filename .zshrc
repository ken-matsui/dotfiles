##################################
# .zshrc
##################################

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

for config in $ZHOMEDIR/config/**/*.zsh; do source $config; done
for config in $ZHOMEDIR/software_config/**/*.zsh; do source $config; done
for config in $ZHOMEDIR/config_lazy/**/*.zsh; do source $config; done

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
