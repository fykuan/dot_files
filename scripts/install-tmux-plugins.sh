#!/usr/bin/env bash
set -e

# Install tpm
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing tpm (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    echo "tpm already installed ✓"
fi

# Install plugins (requires tmux running)
if command -v tmux &> /dev/null && tmux info &> /dev/null; then
    echo "Installing tmux plugins..."
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
else
    echo "Tmux not running. Plugins will install on first tmux launch."
    echo "After starting tmux, press prefix + I to install plugins."
fi

echo "Tmux plugin manager installed!"
