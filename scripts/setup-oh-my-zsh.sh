#!/usr/bin/env bash
set -e

# Install oh-my-zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing oh-my-zsh..."

    # Backup our custom .zshrc if it's a symlink
    if [[ -L "$HOME/.zshrc" ]]; then
        ZSHRC_TARGET=$(readlink "$HOME/.zshrc")
        echo "  Backing up custom .zshrc symlink..."
    fi

    # Install oh-my-zsh (this will overwrite .zshrc)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # Restore our custom .zshrc symlink
    if [[ -n "$ZSHRC_TARGET" ]]; then
        echo "  Restoring custom .zshrc..."
        rm -f "$HOME/.zshrc"
        ln -s "$ZSHRC_TARGET" "$HOME/.zshrc"
    fi
else
    echo "oh-my-zsh already installed ✓"
fi

# Install zsh-autosuggestions
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions already installed ✓"
fi

# Install zsh-autocomplete
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ]]; then
    echo "Installing zsh-autocomplete..."
    git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git \
        "$ZSH_CUSTOM/plugins/zsh-autocomplete"
else
    echo "zsh-autocomplete already installed ✓"
fi

echo "Oh-my-zsh setup complete!"
