#
# Executes commands at login post-zshrc.
#

# Compile the completion dump to increase startup speed.
# ref: https://github.com/sorin-ionescu/prezto/issues/1418#issue-248185664
zcompdump="${ZDOT_ROOT:-$HOME}/.zcompdump"
autoload -Uz compinit zcompile
if [[ -n $zcompdump(#qN.mh+24) ]]; then
  compinit -i "$zcompdump"
  zcompile "$zcompdump"
else
  compinit -i -C
fi

# Do compaudit if receive warnings on compinit; to fix on macOS, chmod -R go-w $DIR
