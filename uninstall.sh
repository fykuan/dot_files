#!/usr/bin/env bash

# remove all dotfiles
rm -fr \
    ~/.Xresources \
    ~/.dotfiles \
    ~/.gitconfig \
    ~/.gitconfig* \
    ~/.oh-my-zsh* \
    ~/.tmux \
    ~/.tmux* \
    ~/.vim* \
    ~/.xinitrc \
    ~/.zim \
    ~/.zsh*

rm ~/.tmux.conf.local
rm ~/.zimrc
rm ~/.config/starship.toml
rm ~/.zprofile
