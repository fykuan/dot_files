#!/usr/bin/env bash
set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
REPO_URL="git@github.com:fykuan/dot_files.git"

echo "╔════════════════════════════════════════╗"
echo "║     Dotfiles Bootstrap Installer       ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✓ Homebrew already installed"
fi

# Ensure brew is in PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install essential tools
echo ""
echo "🔧 Installing essential tools (git, stow)..."
brew install git stow

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

echo ""
echo "🐚 Setting up oh-my-zsh..."
./scripts/setup-oh-my-zsh.sh

# Stow dotfiles
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
