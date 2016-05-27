#!/usr/bin/env sh

export LANG=zh_TW.UTF-8
export LC_ALL=zh_TW.UTF-8

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

[ -f ~/.Xresources  ] && xrdb -merge ~/.Xresources

# Load ibus-daemon
ibus-daemon -drx
exec i3
