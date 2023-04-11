# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

read -p 'Do you want to log in with Zsh? [Y/n] ' yn
case $yn in
  y|Y|'') # Enter key
    exec zsh
    ;;
esac
