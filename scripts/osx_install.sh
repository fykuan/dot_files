#!/usr/bin/env bash
#

# Check if homebrew is installed
if [ $(which brew) == 0 ]; then
    echo "Homebrew is not installed"
    exit
fi

# Install casks
brew cask install iina shotcut
