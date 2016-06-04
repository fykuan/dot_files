#!/usr/bin/env bash

GITDIR=`pwd`

git submodule init && git submodule update --recursive

# check if git is installed
if which git ; then
    echo "[1;33mgit is installed[m"
else
    echo "git is not installed"
    exit 0
fi

# check if pip is installed
if which pip ; then
    echo "[1;33mpip is installed[m"
else
    echo "pip is not installed"
fi

# check if sudo is installed
if which sudo ; then
    echo "[1;33msudo is installed[m"
else
    echo "sudo is not installed"
fi

if [ $(uname) == "Darwin" ]; then
    # Mac OS
    echo "Running installer on OSX..."
    # Install homwbrew if not exist
    if [ $(which brew) == 0 ]; then
        echo "=== Installing homebrew ==="
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    # Install rcm if not exist
    if [ $(which lsrc) == 0 ]; then
        echo "=== Installing rcm ==="
        brew tap thoughtbot/formulae
        brew install rcm
    fi
fi

# clone .dotfiles from github
if [ -d ~/.dotfiles ]; then
    rm -fr ~/.dotfiles
fi
git clone git@github.com:fykuan/dotfiles ~/.dotfiles
# use rcm to install dot files
rcup -v

# General
# oh-my-zsh
if [ -e $HOME/.oh-my-zsh ]; then
    mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh.bak
fi
ln -s $GITDIR/modules/oh-my-zsh $HOME/.oh-my-zsh

# zsh-autosuggestion
if [ -e $HOME/.zsh-autosuggestions ]; then
    rm -fr $HOME/.zsh-autosuggestions
fi
ln -s $GITDIR/modules/zsh-autosuggestions $HOME/.zsh-autosuggestions

# install powerline
cd $GITDIR/modules/powerline && git checkout master && sudo python setup.py install

#install spf13-vim
curl http://j.mp/spf13-vim3 -L -o - | sh

# zsh-autosuggestionsi
if [ -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    rm -fr $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
git clone git://github.com/tarruda/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

cat > $HOME/.tmux.conf.source << EOF

# 把 powerline 和 zsh-syntax-highlighting 載入 zshrc
source "$GITDIR/modules/powerline/powerline/bindings/tmux/powerline.conf"
EOF

cat > $HOME/.zshrc.source << EOF
source "$GITDIR/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
EOF


if [ ! -d ~/.vim ]; then
    mkdir -p $HOME/.vim
fi

if [ -d ~/.vim/skel ]; then
    rm -fr ~/.vim/skel
fi

ln -s $GITDIR/vim-skel ~/.vim/skel
