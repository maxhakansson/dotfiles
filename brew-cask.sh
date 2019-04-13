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
brew cask install lastpass
brew cask install alfred
brew cask install slack
brew cask install spotify
brew cask install copyq
#brew cask install flux

# dev
brew cask install iterm2
brew cask install sublime-text
brew cask install imageoptim
brew cask install diffmerge
brew cask install docker
brew cask install java
brew cask install virtualbox
brew cask install sourcetree

# fun
# brew cask install limechat
#brew cask install miro-video-converter
# brew cask install horndis               # usb tethering

# browsers
brew cask install google-chrome-canary
# brew cask install firefoxnightly
# brew cask install webkit-nightly
# brew cask install chromium
# brew cask install torbrowser

# less often
brew cask install disk-inventory-x
#brew cask install screenflow
brew cask install vlc


# Not on cask but I want regardless.
