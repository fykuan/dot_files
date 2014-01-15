#!/bin/sh
#
GITDIR=`pwd`
# 先把oh-my-zsh抓回來
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
#
mkdir -p $HOME/.oh-my-zsh/custom/plugins && cd $HOME/.oh-my-zsh/custom/plugins && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
#
cd $HOME
#
# 把檔案複製到$HOME
#
if [ -e $HOME/.tmux.conf ]; then
    mv $HOME/.tmux.conf $HOME/.tmux.conf.bak
fi

ln -s $GITDIR/tmux.conf $HOME/.tmux.conf
#
if [ -e $HOME/.vim ]; then
    mv $HOME/.vim $HOME/.vim.bak
fi

ln -s $GITDIR/vim $HOME/.vim
#
if [ -e $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc.bak
fi

ln -s $GITDIR/vimrc $HOME/.vimrc
#
if [ -e $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc.bak
fi

ln -s $GITDIR/zshrc $HOME/.zshrc
#
if [ -e $HOME/.gitconfig ]; then
    mv $HOME/.gitconfig $HOME/.gitconfig.bak
fi

ln -s $GITDIR/gitconfig $HOME/.gitconfig
#
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
