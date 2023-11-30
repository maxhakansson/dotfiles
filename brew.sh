#!/bin/bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade


# GNU core utilities (those that come with OS X are outdated)
#brew install coreutils
#brew install moreutils

# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
#brew install findutils
# GNU `sed`, overwriting the built-in `sed`
#brew install gnu-sed --with-default-names

# Install zsh
brew install zsh

# Install wget
brew install wget

# Install more recent versions of some OS X tools
#brew install grep
#brew install openssh
#brew install nano

# mtr - ping & traceroute. best.
brew install mtr

    # allow mtr to run without sudo
    mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/max/.homebrew/Cellar/mtr/0.86`
    sudo chmod 4755 $mtrlocation/sbin/mtr
    sudo chown root $mtrlocation/sbin/mtr


# fzf is a general-purpose command-line fuzzy finder
brew install fzf

brew install z
#brew install git
#brew install git-flow
#brew install imagemagick --with-webp
brew install node # This installs `npm` too using the recommended installation method
brew install adoptopenjdk13 #JDK for Android
#brew install ffmpeg --with-libvpx
brew install ngrok
brew install pidcat   # colored logcat guy
brew install iftop # top for network
brew install telnet
brew install shpotify
brew install ncdu # find where your diskspace went
brew install go
brew install gnu-tar
brew install diff-so-fancy
#brew install redis
#brew install php
#brew install awscli

# Remove outdated versions from the cellar
brew cleanup

# brew autoremove removes all unused dependencies
