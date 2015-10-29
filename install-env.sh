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

if [ -e $HOME/.tmux.conf.source ]; then
    rm -f $HOME/.tmux.conf.source
fi

if [ -e $HOME/.zsh-autosuggestions ]; then
    rm -fr $HOME/.zsh-autosuggestions
fi
ln -s $GITDIR/modules/zsh-autosuggestions $HOME/.zsh-autosuggestions

if [ -e $HOME/.tmux.conf.source ]; then
    rm -fr $HOME/.tmux.conf.source
fi
ln -s $GITDIR/tmux.conf.source $HOME/.tmux.conf.source
ln -s $GITDIR/tmux.conf.source.osx $HOME/.tmux.conf.source.osx

cat >> $HOME/.tmux.conf.source << EOF
source "$GITDIR/modules/powerline/powerline/bindings/tmux/powerline.conf"
EOF

cat >> $HOME/.zshrc.source << EOF
source "$GITDIR/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
EOF

curl http://j.mp/spf13-vim3 -L -o - | sh
