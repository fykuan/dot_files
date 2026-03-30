# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dpoggi"
plugins=(git zsh-autosuggestions history copypath pyenv zsh-autocomplete)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# FZF key bindings and completion (load AFTER zsh-autocomplete to avoid conflicts)
if command -v fzf &> /dev/null; then
    # Try modern fzf --zsh first (fzf >= 0.48.0), fallback to manual setup
    if fzf --zsh &>/dev/null; then
        eval "$(fzf --zsh)"
    else
        # Fallback for older fzf versions
        # Determine fzf installation location
        if [[ -f ~/.fzf.zsh ]]; then
            source ~/.fzf.zsh
        elif [[ -d /usr/share/fzf ]]; then
            # Common Linux location
            source /usr/share/fzf/key-bindings.zsh 2>/dev/null
            source /usr/share/fzf/completion.zsh 2>/dev/null
        elif [[ -n "$(brew --prefix 2>/dev/null)" ]]; then
            # Homebrew installation
            local fzf_base="$(brew --prefix)/opt/fzf"
            [[ -f "$fzf_base/shell/key-bindings.zsh" ]] && source "$fzf_base/shell/key-bindings.zsh"
            [[ -f "$fzf_base/shell/completion.zsh" ]] && source "$fzf_base/shell/completion.zsh"
        fi
    fi
    # Ensure Ctrl-R is bound to fzf history search
    bindkey '^R' fzf-history-widget 2>/dev/null || true
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
