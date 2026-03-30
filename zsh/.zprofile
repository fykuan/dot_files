cd "$HOME"

# PATH configuration
PATHDIRS=(
    /opt/local/bin
    /opt/local/sbin
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /sbin
)
path=($path $PATHDIRS)

# Homebrew (detect OS and use correct path)
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    # macOS (Apple Silicon)
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
    # macOS (Intel)
    eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    # Linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Add various bin directories to PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/sbin:/usr/sbin:/sbin:/sbin:/bin:/usr/sbin:/usr/local/bin:/usr/bin:/usr/games:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:$HOME/Library/Python/3.9/bin:$PATH"

# Support pip install --user
if [ -d $HOME/Library/Python/2.7/bin ]; then
   export PATH=$HOME/Library/Python/2.7/bin:$PATH
fi

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin"

# pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)" 2>/dev/null || true
fi

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
