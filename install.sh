#!/usr/bin/env bash
#
#############################################
# Install homebrew if not already installed #
#############################################
if ! command -v brew &> /dev/null
then
    /bin/bash -c "NONINTERACTIVE=1; $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

########################################
# Install git if not already installed #
########################################
if ! command -v git &> /dev/null
then
    /opt/homebrew/bin/brew install git
fi

########################################
# Install rcm if not already installed #
########################################
if ! command -v rcup &> /dev/null
then
    /opt/homebrew/bin/brew tap thoughtbot/formulae
    /opt/homebrew/bin/brew install rcm
fi

###############################
# clone .dotfiles from github #
###############################
rm -fr ~/.dotfiles
git clone https://github.com/fykuan/dotfiles ~/.dotfiles
rcup -v

#########################################
# Install tmux if not already installed #
#########################################
if ! command -v tmux &> /dev/null
then
    /opt/homebrew/bin/brew install tmux
fi
###########
# General #
###########
mkdir -p ~/.vim/autoload
# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

###################
# Run PlugInstall #
###################
vim +PlugInstall +qall
#
# reset git username and email
#
git config --unset --global user.name
git config --unset --global user.email

###############
# Install tpm #
###############
rm -fr ~/.tmux/plugins/tpm
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

########################
# Tmux custom settings #
########################
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

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'erikw/tmux-powerline.git'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF
##############################################
# Install oh-my-zsh if not already installed #
##############################################
if [ ! -d ~/.oh-my-zsh ]
then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

#############################################
# Install Starship if not already installed #
#############################################
if ! command -v starship &> /dev/null
then
    /opt/homebrew/bin/brew install starship
fi

#############################################
# Install autojump if not already installed #
#############################################
if ! command -v autojump &> /dev/null
then
    /opt/homebrew/bin/brew install autojump
fi
cat >> ~/.zshrc <<EOF
[[ -s \$(brew --prefix)/etc/profile.d/autojump.sh ]] && . \$(brew --prefix)/etc/profile.d/autojump.sh
EOF

####################
# Source .zprofile #
####################
cat >> ~/.zshrc <<EOF
[[ -s ~/.zprofile ]] && source ~/.zprofile
EOF

################
# Update zshrc #
################
sed -i'.bak' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="dpoggi"/1' ~/.zshrc
sed -i'.bak' 's/plugins=(git)/plugins=(git zsh-autosuggestions history copypath autojump pyenv fzf zsh-autocomplete)/1' ~/.zshrc

###############################
# Install zsh-autosuggestions #
###############################
rm -fr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

############################
# Install zsh-autocomplete #
############################
rm -fr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

###################
# Config Starship #
###################
cat >> ~/.zshrc <<EOF
eval "\$(starship init zsh)"
EOF
