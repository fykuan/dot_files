#!/usr/bin/env bash
set -e

# Create tmux plugins directory
mkdir -p "$HOME/.tmux/plugins"

# Install tpm
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing tpm (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    echo "tpm already installed ✓"
fi

# Install plugins
if command -v tmux &> /dev/null; then
    if tmux info &> /dev/null 2>&1; then
        # Tmux is running - use the installer
        echo "Installing tmux plugins..."
        "$HOME/.tmux/plugins/tpm/bin/install_plugins" || true
    else
        # Tmux not running - plugins will install on first launch
        echo "Tmux plugins will install automatically on first tmux launch."
        echo "Or press prefix + I (Ctrl-a + I) inside tmux to install manually."
    fi
else
    echo "Tmux not found. Install tmux first, then run this script again."
fi

echo "Tmux plugin manager installed!"
