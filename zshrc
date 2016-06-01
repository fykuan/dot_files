ZSH=$HOME/.oh-my-zsh
ZSH_THEME="dallas"
plugins=(cp git zsh-syntax-highlighting docker zsh-autosuggestions)
source $HOME/.oh-my-zsh/oh-my-zsh.sh
cd "$HOME"

# 設定$PATH
PATHDIRS=(
    /opt/local/bin
    /opt/local/sbin
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /sbin
)
path=($path $PATHDIRS)

# 自己用的順手的alias
alias c="clear"
alias cd..="cd .."
alias cd...="cd ../.."
alias cls="clear"
alias g="grep --color=auto"
alias ssh="ssh -4 -C -e none"
alias vi="vim"
alias tmux="tmux -2"
alias ta="tmux attach"
alias yh="ypcat hosts"
alias qotd="curl -s http://wowquote.tw/quote/random\?json\=1 | jq '.celebrity.name + \"：\" + .quote[0]' | cowsay -f www -d -n"
alias lock="i3lock -i ~/arch-wallpapers/wallhaven-333506.png"
alias rainbowstream="~/venv/bin/python ~/venv/bin/rainbowstream"
alias bb="byobu"

# 環境變數
export EDITOR VISUAL HOME
export BLOCKSIZE="k"
export EDITOR="vim"
export GIT_PAGER="less"
export LESS="-EfmrSwX"
export LSCOLORS="gxfxcxdxbxegedabagacad"
export PATH="/usr/local/sbin:/usr/sbin:/sbin:/sbin:/bin:/usr/sbin:/usr/local/bin:/usr/bin:/usr/games:/usr/local/sbin:/home/allenkuan/bin:$PATH"
export PERL_CPANM_OPT="--mirror http://cpan.nctu.edu.tw/ --mirror http://cpan.cpantesters.org/"
#export TERM=screen-256color
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus

#TERM=screen-256color


if [ -x /usr/local/bin/most -o -x /usr/bin/most -o -x /opt/local/bin/most ]; then
    export PAGER="most"
    alias more="most"
else
    export PAGER="less"
    alias more="less"
fi

# 讓iterm2的tab名稱顯示：@${HOSTNAME.*}: ${PWD/#$HOME/~
HOSTNAME="`hostname`"
function precmd {
    echo -n "]0;@${HOSTNAME%%.*}: ${PWD/#$HOME/~}"
}
#   拿掉oh-my-zsh的AUTO_TITLE，否則上面設定的tab名稱會一直被蓋掉
DISABLE_AUTO_TITLE=true

source "$HOME/.zshrc.source"

# Disable zsh-autosuggestions
#
#source ~/.zsh-autosuggestions/autosuggestions.zsh
#zle-line-init() {
#    zle autosuggest-start
#}
#zle -N zle-line-init
#bindkey '^T' autosuggest-toggle
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#
#
#
#curl http://wttr.in/taipei
#
#if which curl > /dev/null 2>&1  && which jq > /dev/null 2>&1 && which cowsay > /dev/null 2>&1; then
#    if ping -c 1 -q -t 1 8.8.8.8 > /dev/null 2>&1; then
#        curl -s http://wowquote.tw/quote/random\?json\=1 | jq '.celebrity.name + "：" + .quote[0]' | cowsay -f www -d -n
#    fi
#fi

# urxvt
#bindkey -s "\e[11~" ""
#bindkey -s "\e[12~" ""
#bindkey -s "\e[13~" ""
#bindkey -s "\e[14~" ""
#bindkey -s "\e[15~" ""
#bindkey -s "\e[17~" ""
#bindkey -s "\e[18~" ""
#bindkey -s "\e[19~" ""
#bindkey -s "\e[20~" ""
#bindkey -s "\e[21~" ""
#bindkey -s "\e[23~" ""
