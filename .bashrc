# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Return if not interactive
[ -z "${PS1:-}" ] && return

read -p 'Do you want to log in with Zsh? [Y/n] ' yn
case $yn in
  y|Y|'') # accept an enter key
    exec zsh
    ;;
esac
