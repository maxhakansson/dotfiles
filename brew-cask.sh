#!/bin/bash


# to maintain cask ....
# brew update && brew upgrade && brew cleanup


# Install native apps
brew tap homebrew/cask
# daily
brew install --cask raycast # Replaces slate, copyq and Alfred
brew install --cask dropbox
brew install --cask slack
brew install --cask spotify
brew install --cask flux
# brew install --cask spectacle

# dev
brew install --cask ghostty #terminal
brew install --cask visual-studio-code
# brew install --cask sublime-text
brew install --cask sublime-merge
# brew install --cask imageoptim
# brew install --cask diffmerge
brew install --cask docker
brew tap homebrew/cask-versions
brew install --cask temurin@8 # adoptopenjdk16 is deprecated
brew install --cask temurin@17
brew install --cask virtualbox
brew install --cask sourcetree
brew install --cask postman
brew install --cask charles
brew install --cask android-studio

# open source font package
# brew tap homebrew/cask-fonts
# brew install font-inconsolata


# browsers
brew install --cask google-chrome
# brew install --cask torbrowser

# less often
# brew install --cask disk-inventory-x
# brew install --cask screenflow
# brew install --cask vlc

brew cleanup
