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
