#!/usr/bin/env bash
set -e

# Install vim-plug
if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    echo "Installing vim-plug..."
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug already installed ✓"
fi

# Install vim plugins
echo "Installing Vim plugins..."
vim +PlugInstall +qall

echo "Vim plugins installed!"
