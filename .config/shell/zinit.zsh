##################################
# Zinit Options & Plugins
##################################

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

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
