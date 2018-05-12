# /bin/bash


# Change shell as default for USER(not root).
sudo chsh -s /bin/zsh "${USER}" 1>/dev/null
# Install zsh-prezto.
git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Install tpm
git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Link setting files.
for conf in $(find ${DOTSPATH}/config -type f); do
	ln -sf "$conf" "${HOME}/${conf##*/}"
done
