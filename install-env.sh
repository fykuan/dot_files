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
rm $HOME/.tmux.conf
ln -s $GITDIR/tmux.conf $HOME/.tmux.conf
#
rm -r $HOME/.vim
ln -s $GITDIR/vim $HOME/.vim
#
rm $HOME/.vimrc
ln -s $GITDIR/vimrc $HOME/.vimrc
#
rm $HOME/.zshrc
ln -s $GITDIR/zshrc $HOME/.zshrc
#
rm $HOME/.gitconfig
ln -s $GITDIR/gitconfig $HOME/.gitconfig
#
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
