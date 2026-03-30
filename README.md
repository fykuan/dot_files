# dotfiles

Modern dotfiles management using GNU Stow for zsh, vim, tmux, and more.

## 📦 What's Included

- **Git** - Global git configuration with local override support
- **Vim** - vim-plug based plugin management with sensible defaults
- **Tmux** - Terminal multiplexer with tpm plugin manager
- **Zsh** - Modular oh-my-zsh configuration with starship prompt
- **Starship** - Fast, customizable shell prompt
- **WezTerm** - Terminal emulator configuration
- **Xorg** - X11 configuration (Linux only)

## 🚀 Quick Start

### One-Line Installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/fykuan/dot_files/main/bootstrap.sh)"
```

### Manual Installation

```bash
# 1. Clone this repository
git clone git@github.com:fykuan/dot_files.git ~/.dotfiles
cd ~/.dotfiles

# 2. Run bootstrap script
./bootstrap.sh
```

The bootstrap script will:
1. Install Homebrew (if needed)
2. Install required packages (git, stow, tmux, starship, autojump)
3. Setup oh-my-zsh and plugins
4. Create symlinks using GNU Stow
5. Install vim and tmux plugins

## 📁 Repository Structure

```
dotfiles/
├── git/              # Git configuration
│   └── .gitconfig
├── vim/              # Vim configuration
│   └── .vimrc
├── tmux/             # Tmux configuration
│   ├── .tmux.conf
│   └── .tmux/        # Plugin directory
├── zsh/              # Zsh configuration
│   ├── .zshrc        # Main zsh config
│   ├── .zprofile     # Login shell config
│   └── .config/zsh/  # Modular configs
│       ├── aliases.zsh
│       ├── environment.zsh
│       └── functions.zsh
├── starship/         # Starship prompt
│   └── .config/starship.toml
├── wezterm/          # WezTerm terminal
│   └── .wezterm.lua
├── xorg/             # X11 configs (Linux only)
│   ├── .xinitrc
│   └── .Xresources
└── scripts/          # Installation scripts
    ├── install-brew-packages.sh
    ├── setup-oh-my-zsh.sh
    ├── install-vim-plugins.sh
    └── install-tmux-plugins.sh
```

## 🔧 GNU Stow Workflow

### How It Works

GNU Stow creates symlinks from this repository to your home directory:
- `git/.gitconfig` → `~/.gitconfig`
- `vim/.vimrc` → `~/.vimrc`
- `zsh/.zshrc` → `~/.zshrc`
- `starship/.config/starship.toml` → `~/.config/starship.toml`

### Basic Commands

```bash
cd ~/.dotfiles

# Stow individual package
stow -t ~ git         # Creates ~/.gitconfig symlink

# Stow multiple packages
stow -t ~ vim tmux zsh

# Stow all packages
for pkg in */; do stow -t ~ "$pkg"; done

# Remove symlinks (unstow)
stow -t ~ -D vim

# Restow (useful after editing)
stow -t ~ -R vim

# Dry run (see what would happen)
stow -t ~ -n vim
```

**Note:** The `-t ~` flag specifies the target directory (home directory). This is necessary when the dotfiles repo is not directly in `~`.

### Using the Makefile

```bash
# Stow all packages
make install

# Remove all symlinks
make uninstall

# Restow all packages
make restow
```

## ⚙️ Customization

### Git Configuration

Create `~/.gitconfig.local` for machine-specific settings:

```gitconfig
[user]
    name = Your Name
    email = your@email.com
```

This file is automatically included by the main `.gitconfig`.

### Zsh Configuration

Modular configuration files in `~/.config/zsh/`:

- **aliases.zsh** - Add your custom aliases
- **environment.zsh** - Environment variables
- **functions.zsh** - Shell functions

Edit these files and the changes take effect after `source ~/.zshrc`.

### Vim Plugins

Edit `vim/.vimrc` and add plugins between `call plug#begin()` and `call plug#end()`:

```vim
Plug 'your-plugin/here'
```

Then run:
```bash
vim +PlugInstall +qall
```

### Tmux Plugins

Edit `tmux/.tmux.conf` and add plugins:

```bash
set -g @plugin 'plugin-name'
```

In tmux, press `prefix + I` to install new plugins.

## 🔍 Installed Tools

### Homebrew Packages
- git
- stow (dotfile manager)
- tmux (terminal multiplexer)
- starship (shell prompt)
- autojump (directory navigation)

### Zsh Plugins (oh-my-zsh)
- git
- zsh-autosuggestions
- zsh-autocomplete
- history
- copypath
- autojump
- pyenv
- fzf

### Vim Plugins
- vim-airline (status line)
- vim-indent-guides
- vim-better-whitespace
- tomorrow-theme (color scheme)
- vim-polyglot (language support)
- vim-gitgutter
- vim-rainbow
- auto-pairs
- nerdtree (file explorer)
- vim-easycomplete
- ultisnips (snippets)
- vim-devicons (icons)

### Tmux Plugins
- tpm (plugin manager)
- tmux-sensible
- tmux-gruvbox (theme)
- catppuccin/tmux (theme)

## 🐛 Troubleshooting

### Stow Conflicts

If stow reports conflicts (existing files), you have two options:

1. **Backup and remove existing files:**
   ```bash
   mv ~/.vimrc ~/.vimrc.backup
   stow vim
   ```

2. **Adopt existing files into the repo:**
   ```bash
   stow --adopt vim
   ```
   (This moves the existing file into the repo and creates a symlink)

### Zsh Not Using Custom Config

Make sure you've restarted your shell:
```bash
exec zsh
```

Or source the config:
```bash
source ~/.zshrc
```

### Tmux Plugins Not Installing

1. Make sure tmux is running
2. Press `prefix + I` (default prefix is `C-a`)
3. Or run manually:
   ```bash
   ~/.tmux/plugins/tpm/bin/install_plugins
   ```

### Vim Plugins Not Installing

Run the installation command:
```bash
vim +PlugInstall +qall
```

Or inside vim:
```
:PlugInstall
```

## 📝 Migration from Old Setup

If you're migrating from the old rcm-based setup:

```bash
# 1. Backup existing configs
cp -r ~/.dotfiles ~/.dotfiles.backup
cp ~/.zshrc ~/.zshrc.backup

# 2. Remove old rcm symlinks
rcdn  # Or manually: rm ~/.vimrc ~/.tmux.conf ~/.gitconfig etc.

# 3. Clone and run new setup
git clone git@github.com:fykuan/dot_files.git ~/.dotfiles-new
cd ~/.dotfiles-new
./bootstrap.sh

# 4. Verify everything works, then cleanup
rm -rf ~/.dotfiles.backup
```

## 📄 License

MIT License - Feel free to use and modify as needed.

## 🙏 Credits

- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink manager
- [oh-my-zsh](https://ohmyz.sh/) - Zsh framework
- [Starship](https://starship.rs/) - Shell prompt
- [vim-plug](https://github.com/junegunn/vim-plug) - Vim plugin manager
- [tpm](https://github.com/tmux-plugins/tpm) - Tmux plugin manager
