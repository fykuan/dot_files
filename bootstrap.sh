#!/usr/bin/env bash
set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
REPO_URL="git@github.com:fykuan/dot_files.git"

echo "╔════════════════════════════════════════╗"
echo "║     Dotfiles Bootstrap Installer       ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Detect Homebrew installation path
if [[ "$OSTYPE" == "darwin"* ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$($BREW_PREFIX/bin/brew shellenv)"
else
    echo "✓ Homebrew already installed"
fi

# Ensure brew is in PATH
if [[ -x "$BREW_PREFIX/bin/brew" ]]; then
    eval "$($BREW_PREFIX/bin/brew shellenv)"
else
    echo "Warning: Homebrew not found at $BREW_PREFIX"
    echo "Attempting to find brew in PATH..."
fi

# Install essential tools
echo ""
echo "🔧 Installing essential tools..."

# Check and install git if needed
if ! command -v git &> /dev/null; then
    echo "  Installing git..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "  Note: Consider installing git via system package manager (apt/yum) instead"
        echo "  Example: sudo apt-get install git"
        read -p "  Install git via Homebrew? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            brew install git
        else
            echo "  Skipping git installation. Please install git manually."
            exit 1
        fi
    else
        brew install git
    fi
else
    echo "  ✓ git already installed"
fi

# Install stow
if ! brew list stow &> /dev/null 2>&1; then
    echo "  Installing stow..."
    brew install stow
else
    echo "  ✓ stow already installed"
fi

# Clone dotfiles if running remotely
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo ""
    echo "📥 Cloning dotfiles repository..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
else
    echo ""
    echo "✓ Dotfiles repository already exists at $DOTFILES_DIR"
    cd "$DOTFILES_DIR"
fi

# Make scripts executable
chmod +x scripts/*.sh

# Run installation scripts
echo ""
echo "📦 Installing Homebrew packages..."
./scripts/install-brew-packages.sh

# Stow dotfiles FIRST (before oh-my-zsh installation)
echo ""
echo "🔗 Creating symlinks with GNU Stow..."

# Detect OS for platform-specific stowing
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PACKAGES="git vim tmux zsh starship wezterm xorg"
    echo "  Detected Linux - including xorg configs"
else
    PACKAGES="git vim tmux zsh starship wezterm"
    echo "  Detected macOS - skipping xorg configs"
fi

for package in $PACKAGES; do
    echo "  Stowing $package..."
    stow -t ~ -v "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
done

echo ""
echo "✓ Symlinks created successfully"

# Install oh-my-zsh AFTER stowing .zshrc
echo ""
echo "🐚 Setting up oh-my-zsh..."
./scripts/setup-oh-my-zsh.sh

# Install Vim plugins
echo ""
echo "📝 Installing Vim plugins..."
./scripts/install-vim-plugins.sh

# Install Tmux plugins
echo ""
echo "🖥️  Installing Tmux plugins..."
./scripts/install-tmux-plugins.sh

echo ""
echo "╔════════════════════════════════════════╗"
echo "║       Installation Complete! 🎉        ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Set your git identity:"
echo "     git config --global user.name 'Your Name'"
echo "     git config --global user.email 'your@email.com'"
echo ""
echo "  2. Restart your shell:"
echo "     exec zsh"
echo ""
echo "  3. Optional: Review ~/.config/zsh/ for customization"
echo ""
echo "  4. Tmux plugins: Launch tmux and press prefix + I to install"
echo ""
