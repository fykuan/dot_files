#!/bin/sh
#
GITDIR=`pwd`
# 先把submodule拉回來
git submodule init && git submodule update --recursive
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
if [ -e $HOME/.oh-my-zsh ]; then
    mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh.bak
fi
ln -s $GITDIR/modules/oh-my-zsh $HOME/.oh-my-zsh

cd $HOME/.oh-my-zsh/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

if [ -e $HOME/.tmux.conf.source ]; then
    rm -f $HOME/.tmux.conf.source
fi
cat >> $HOME/.tmux.conf.source << EOF
source "$GITDIR/modules/powerline/powerline/bindings/tmux/powerline.conf"
EOF
