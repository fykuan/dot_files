# iTerm2 tab title configuration
HOSTNAME="`hostname`"
function precmd {
    echo -ne "\033]0;@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"
}

# Disable oh-my-zsh AUTO_TITLE to prevent overriding
DISABLE_AUTO_TITLE=true
