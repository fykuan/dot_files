# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dpoggi"
plugins=(git zsh-autosuggestions history copypath pyenv zsh-autocomplete)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# FZF key bindings and completion (load AFTER zsh-autocomplete to avoid conflicts)
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
    # Ensure Ctrl-R is bound to fzf history search
    bindkey '^R' fzf-history-widget
fi

# Load custom configurations
if [ -d "$HOME/.config/zsh" ]; then
    source "$HOME/.config/zsh/environment.zsh"
    source "$HOME/.config/zsh/aliases.zsh"
    source "$HOME/.config/zsh/functions.zsh"
fi

# Zoxide (smarter cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# Starship prompt (overrides oh-my-zsh theme)
eval "$(starship init zsh)"
