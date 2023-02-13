#!/usr/bin/env bash

#
# check operation system
#
if [ $(uname) == "Darwin" ]; then
    export CURRENT_OS='macos'
elif which apt-get; then
    export CURRENT_OS='debian'
elif which pacman; then
    export CURRENT_OS='arch'
elif which pkg; then
    export CURRENT_OS='freebsd'
else
    export CURRENT_OS='other'
fi

GITDIR=`pwd`

git submodule init && git submodule update --recursive

# check if git is installed
if which git ; then
    echo "[1;33mgit is installed[m"
else
    echo "[1;31mgit is not installed[m"
    exit 0
fi

# check if sudo is installed
if which sudo ; then
    echo "[1;33msudo is installed[m"
else
    echo "[1;31msudo is not installed[m"
    exit 0
fi

if [ ${CURRENT_OS} == "macos" ]; then
    # Mac OS
    echo "[1;37mRunning installer on OSX...[m"
    # Install homwbrew if not exist
    if [ $(which brew) == 0 ]; then
        echo "=== Installing homebrew ==="
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    # Install rcm if not exist
    if ! which lsrc; then
        echo "=== Installing rcm ==="
        brew tap thoughtbot/formulae
        brew install rcm
    fi
    # Install starship if not exist
    if ! which starship; then
        brew install starship
    fi
elif [ ${CURRENT_OS} == "debian" ]; then
    # Debian / Ubuntu
    echo "[1;37mRunning installer on Debian/Ubuntu...[m"
    # Install rcm
    sudo apt install rcm -y
    # Install starship
    sudo snap install starship
elif [ ${CURRENT_OS} == "arch" ]; then
    # ArchLinux
    echo "[37mRunning installer on ArchLinux...[m"
    cd /tmp && wget https://aur.archlinux.org/cgit/aur.git/snapshot/rcm.tar.gz && tar zxvf rcm.tar.gz && cd rcm && makepkg -s && sudo pacman -U rcm-1.3.0-1-any.pkg.tar.xz
elif [ ${CURRENT_OS} == "freebsd" ]; then
    # FreeBSD
    echo "[37mRunning installer on FreeBSD...[m"
    sudo pkg install rcm
fi

# clone .dotfiles from github
rm -fr ~/.dotfiles

git clone https://github.com/fykuan/dotfiles ~/.dotfiles

# go back
cd -

# use rcm to install dot files
rcup -v

###########
# General #
###########
mkdir -p ~/.vim/autoload

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#
# Run PlugInstall
#
vim +PlugInstall +qall

# reset git username and email
git config --unset --global user.name
git config --unset --global user.email

#
# Install oh-my-zsh
#
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "
#
# Install zsh-autosuggestions
#
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#
# Clone oh-my-tmux
#
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

#
# Tmux custom settings
#
cat >> ~/.tmux.conf.local <<EOF
unbind u
bind v split-window -h
bind | split-window -h
#
## 水平分割視窗
bind h split-window -v
bind - split-window -v
bind -r M-Up resize-pane -U 5
bind -r M-Down resize-pane -D 5
bind -r M-Left resize-pane -L 5
bind -r M-Right resize-pane -R 5

bind-key -n F1 select-window -t 1
bind-key -n F2 select-window -t 2
bind-key -n F3 select-window -t 3
bind-key -n F4 select-window -t 4
bind-key -n F5 select-window -t 5
bind-key -n F6 select-window -t 6
bind-key -n F7 select-window -t 7
bind-key -n F8 select-window -t 8
bind-key -n F9 select-window -t 9
bind-key -n F10 select-window -t 10
bind-key -n F11 select-window -t 11
bind-key -n F12 select-window -t 12
set -g mouse on
EOF

#
# Set oh-my-zsh theme
#
sed -i'.bak' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="dpoggi"/1' ~/.zshrc
#
# Set zsh plugins
#
sed -i'.bak' 's/plugins=(git)/plugins=(git zsh-autosuggestions history copypath autojump pyenv)/1' ~/.zshrc

#
# Load custom zsh settings
#
cat >> ~/.zshrc <<EOF
source ~/.zshrc.local
eval "$(starship init zsh)"
EOF

#
# Link Neovim config
#
mkdir -p ~/.config/nvim && ln -s ~/.vimrc ~/.config/nvim/init.vim
# Install vim-plug for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#
# Link starship config
mkdir -p ~/.config/
ln -s ~/.dotfiles/starship.toml ~/.config/starship.toml
