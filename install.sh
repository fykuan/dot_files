#!/usr/bin/env bash

GITDIR=`pwd`

git submodule init && git submodule update --recursive

# check if git is installed
if which git ; then
    echo "[1;33mgit is installed[m"
else
    echo "[1;31mgit is not installed[m"
    exit 0
fi

# check if pip is installed
if which pip ; then
    echo "[1;33mpip is installed[m"
else
    echo "[1;31mpip is not installed[m"
    if which easy_install ; then
        sudo easy_install pip
    fi
fi

# check if sudo is installed
if which sudo ; then
    echo "[1;33msudo is installed[m"
else
    echo "[1;31msudo is not installed[m"
fi

if [ $(uname) == "Darwin" ]; then
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
elif which apt-get; then
    # Debian / Ubuntu
    echo "[1;37mRunning installer on Debian/Ubuntu...[m"
    # Install rcm
    wget https://thoughtbot.github.io/rcm/debs/rcm_1.3.0-1_all.deb
    sha=$(sha256sum rcm_1.3.0-1_all.deb | cut -f1 -d' ')
    [ "$sha" = "2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d" ] && sudo dpkg -i rcm_1.3.0-1_all.deb
elif which pacman; then
    # ArchLinux
    echo "[37mRunning installer on ArchLinux...[m"
    cd /tmp && wget https://aur.archlinux.org/cgit/aur.git/snapshot/rcm.tar.gz && tar zxvf rcm.tar.gz && cd rcm && makepkg -s && sudo pacman -U rcm-1.3.0-1-any.pkg.tar.xz
elif which pkg; then
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

#install spf13-vim
curl http://j.mp/spf13-vim3 -L -o - | sh

mkdir -p ~/.vim

# remove ~/.vim/skel if exists
rm -fr ~/.vim/skel

ln -s $GITDIR/vim-skel ~/.vim/skel

# reset git username and email
git config --unset --global user.name
git config --unset --global user.email

#
# Install oh-my-zsh
#
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
EOF

#
# Set oh-my-zsh theme
#
sed 's/ZSH_THEME="robbyrussell"/ZSH_THEME="dallas"/1' ~/.zshrc

#
# Load custom zsh settings 
#
cat >> ~/.zshrc <<EOF
source ~/.zshrc.local
EOF
