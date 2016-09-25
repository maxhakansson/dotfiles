#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# daily
# brew cask install spectacle
brew cask install slate
brew cask install dropbox
brew cask install 1password
brew cask install alfred
brew cask install flux
brew cask install sourcetree

# dev
brew cask install iterm2
brew cask install sublime-text
brew cask install imagealpha
brew cask install imageoptim

# fun
# brew cask install limechat
brew cask install miro-video-converter
# brew cask install horndis               # usb tethering

# browsers
brew cask install google-chrome-canary
# brew cask install firefoxnightly
# brew cask install webkit-nightly
# brew cask install chromium
# brew cask install torbrowser

# less often
brew cask install disk-inventory-x
brew cask install screenflow
brew cask install vlc
brew cask install utorrent


# Not on cask but I want regardless.

# File Multi Tool 5
# Phosphor
