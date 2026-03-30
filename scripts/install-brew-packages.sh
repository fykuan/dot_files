#!/usr/bin/env bash
set -e

packages=(
    tmux
    starship
    zoxide
    stow
)

echo "Installing Homebrew packages..."
for package in "${packages[@]}"; do
    if ! brew list "$package" &> /dev/null; then
        echo "  Installing $package..."
        brew install "$package"
    else
        echo "  $package already installed ✓"
    fi
done

echo "Homebrew packages installed!"
