# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dpoggi"
plugins=(git zsh-autosuggestions history copypath autojump pyenv fzf zsh-autocomplete)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Load custom configurations
if [ -d "$HOME/.config/zsh" ]; then
    source "$HOME/.config/zsh/environment.zsh"
    source "$HOME/.config/zsh/aliases.zsh"
    source "$HOME/.config/zsh/functions.zsh"
fi

# Autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Starship prompt (overrides oh-my-zsh theme)
eval "$(starship init zsh)"
