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
rm -fr ~/.dotfiles

git clone https://github.com/fykuan/dotfiles ~/.dotfiles
# use rcm to install dot files
rcup -v

# General
# oh-my-zsh
rm -fr $HOME/.oh-my-zsh
ln -s $GITDIR/modules/oh-my-zsh $HOME/.oh-my-zsh

# zsh-autosuggestion
rm -fr $HOME/.zsh-autosuggestions
ln -s $GITDIR/modules/zsh-autosuggestions $HOME/.zsh-autosuggestions

# install powerline
cd $GITDIR/modules/powerline && git checkout master && sudo python setup.py install

# 把 powerline 和 zsh-syntax-highlighting 載入 zshrc
cat > $HOME/.tmux.conf.source << EOF
source "$GITDIR/modules/powerline/powerline/bindings/tmux/powerline.conf"
EOF

cat > $HOME/.zshrc.source << EOF
source "$GITDIR/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
EOF

#install spf13-vim
curl http://j.mp/spf13-vim3 -L -o - | sh

# zsh-autosuggestions
rm -fr $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone git://github.com/tarruda/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

mkdir -p ~/.vim

# remove ~/.vim/skel if exists
rm -fr ~/.vim/skel

ln -s $GITDIR/vim-skel ~/.vim/skel
