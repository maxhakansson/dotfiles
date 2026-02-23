#!/bin/bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade


# Install zsh
brew install zsh

# Install wget
brew install wget

# mtr - ping & traceroute. best.
brew install mtr

    # allow mtr to run without sudo
    mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/max/.homebrew/Cellar/mtr/0.86`
    sudo chmod 4755 $mtrlocation/sbin/mtr
    sudo chown root $mtrlocation/sbin/mtr


# fzf is a general-purpose command-line fuzzy finder
brew install fzf

# Install zinit for zsh plugin management
brew install zinit

# brew install z
brew install zoxide # better cd
brew install fd # better find (used by fzf internally)
brew install bat
brew install git # Avoid slowdowns of terminal by using git from homebrew
#brew install git-flow
#brew install imagemagick --with-webp
brew install node # This installs `npm` too using the recommended installation method
#brew install ffmpeg --with-libvpx
brew install ngrok
brew install pidcat   # colored logcat guy
brew install iftop # top for network
brew install telnet
brew install shpotify
brew install ncdu # find where your diskspace went
brew install gh #github cli
brew install go
brew install git-delta  # Better diff highlighting (replaces diff-so-fancy)
brew install fnm        # Fast Node.js version manager (replaces nvm)
brew install jenv       # Java version manager
#brew install redis
#brew install php
#brew install awscli

# Remove outdated versions from the cellar
brew cleanup

# brew autoremove removes all unused dependencies
