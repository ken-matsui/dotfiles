##################################
# Zinit Options & Plugins
##################################

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet PZTM::directory

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light momo-lab/zsh-replace-multiple-dots

zinit snippet OMZP::gitignore/gitignore.plugin.zsh
zinit snippet OMZP::git/git.plugin.zsh

zinit ice as"program" pick"bin/git-fuzzy"
zinit light bigH/git-fuzzy

zinit ice wait lucid depth=1
zinit light MichaelAquilina/zsh-you-should-use
export YSU_MESSAGE_POSITION='after'

autoload -Uz is-at-least
if is-at-least 5.1; then
    zinit light MichaelAquilina/zsh-auto-notify
    AUTO_NOTIFY_IGNORE+=("hx")

    # FIXME: zsh-vi-mode messes up ^R history search
    # https://github.com/ohmyzsh/ohmyzsh/issues/5213
    # One possible solution is to source this much earlier.
    # zinit ice depth=1
    # zinit light jeffreytse/zsh-vi-mode
fi