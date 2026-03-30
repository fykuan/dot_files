# Basic aliases
alias c="clear"
alias cd..="cd .."
alias cd...="cd ../.."
alias cls="clear"
alias g="grep --color=auto"
alias ssh="ssh -4 -C -e none"
alias vi="vim"
alias yh="ypcat hosts"
alias bb="byobu"
alias tmux="tmux attach || tmux"
alias sshhosts="find ~/.ssh/ -type f -name '*config*' | xargs sed -rn 's/^\s*Host\s*(.*)/\1/p' | sort"
alias tg="terragrunt"
alias tf="terraform"
alias pbc="pbcopy"
alias pbp="pbpaste"
alias grep="rg"

# Fun aliases
alias qotd="curl -s http://wowquote.tw/quote/random\?json\=1 | jq '.celebrity.name + \"：\" + .quote[0]' | cowsay -f www -d -n"
alias lock="i3lock -i ~/arch-wallpapers/wallhaven-333506.png"
alias rainbowstream="~/venv/bin/python ~/venv/bin/rainbowstream"

# Conditional aliases based on installed tools
if command -v nvim &> /dev/null; then
    alias vim="nvim"
fi

if command -v bat &> /dev/null; then
    alias cat="bat -p --theme=TwoDark"
fi

if command -v eza &> /dev/null; then
    alias ls="eza -g"
fi
