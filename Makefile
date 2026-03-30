.PHONY: help install uninstall restow

help:
	@echo "Dotfiles management with GNU Stow"
	@echo ""
	@echo "Usage:"
	@echo "  make install    - Stow all packages (create symlinks)"
	@echo "  make uninstall  - Unstow all packages (remove symlinks)"
	@echo "  make restow     - Restow all packages (refresh symlinks)"
	@echo ""

install:
	@echo "Creating symlinks with GNU Stow..."
	@stow -v git vim tmux zsh starship wezterm 2>&1 | grep -v "BUG in find_stowed_path" || true
	@if [[ "$$OSTYPE" == "linux-gnu"* ]]; then \
		echo "Detected Linux - stowing xorg configs..."; \
		stow -v xorg 2>&1 | grep -v "BUG in find_stowed_path" || true; \
	fi
	@echo "✓ Symlinks created"

uninstall:
	@echo "Removing symlinks..."
	@stow -D git vim tmux zsh starship wezterm xorg 2>/dev/null || true
	@echo "✓ Symlinks removed"

restow:
	@echo "Refreshing symlinks..."
	@stow -R git vim tmux zsh starship wezterm 2>&1 | grep -v "BUG in find_stowed_path" || true
	@if [[ "$$OSTYPE" == "linux-gnu"* ]]; then \
		stow -R xorg 2>&1 | grep -v "BUG in find_stowed_path" || true; \
	fi
	@echo "✓ Symlinks refreshed"
