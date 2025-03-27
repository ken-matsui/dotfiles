use_starship() {
  if command_exists starship; then
    if require_bash_or_zsh "$0"; then
      eval "$(starship init "$SHELL_NAME")"
    fi
  fi
}

if [ "$SHELL_NAME" != 'zsh' ]; then
  use_starship
  return 0
fi
if ! is-at-least 5.2; then
  use_starship
  return 0
fi

export PURE_GIT_PULL=0

zstyle ':prompt:pure:path' color cyan
zstyle ':prompt:pure:prompt:success' color green
zstyle ':prompt:pure:git:stash' show yes

precmd_datetime() {
  print -P '%F{yellow}[ %D{%Y/%m/%d %a} %* ]%f'
}
add-zsh-hook precmd precmd_datetime

precmd_pipestatus() {
  local exitcodes="${(j.|.)pipestatus}"
  if [[ "$exitcodes" != "0" ]]; then
    print -nP "%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f "
  fi
}
add-zsh-hook precmd precmd_pipestatus

precmd_incognito() {
  if [[ -v ATUIN_INCOGNITO ]]; then
    print -nP "🕶️ "
  fi
}
add-zsh-hook precmd precmd_incognito

precmd_shlvl() {
  if [[ "$SHLVL" -gt 1 ]]; then
    print -nP "%F{magenta}↕ $SHLVL%f "
  fi
}
add-zsh-hook precmd precmd_shlvl

precmd_jobs() {
  print -nP '%F{blue}%(1j.[%j] .)%f'
}
add-zsh-hook precmd precmd_jobs
