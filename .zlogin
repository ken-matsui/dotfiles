#
# Executes commands at login post-zshrc.
#

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  # ref: https://github.com/sorin-ionescu/prezto/issues/1418#issue-248185664
  zcompdump="${ZDOT_ROOT:-$HOME}/.zcompdump"
  autoload -Uz compinit zcompile
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  else
    compinit -i -C
  fi
} &!

# Do compaudit if receive warnings on compinit; to fix on macOS, chmod -R go-w $DIR
