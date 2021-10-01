#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps
brew tap homebrew/cask
brew tap homebrew/cask-versions

# daily
brew install --cask slate
brew install --cask dropbox
brew install --cask alfred
brew install --cask slack
brew install --cask spotify
brew install --cask copyq
brew install --cask flux
# brew install --cask spectacle

# dev
brew install --cask iterm2
brew install --cask visual-studio-code
# brew install --cask sublime-text
# brew install --cask imageoptim
# brew install --cask diffmerge
brew install --cask docker
# brew install --cask java
brew install --cask virtualbox
brew install --cask sourcetree
brew install --cask postman
brew install --cask charles
brew install --cask android-studio

# fun
# brew install --cask limechat
# brew install --cask miro-video-converter
# brew install --cask horndis               # usb tethering

# browsers
brew install --cask google-chrome
# brew install --cask google-chrome-canary
# brew install --cask firefoxnightly
# brew install --cask webkit-nightly
# brew install --cask chromium
# brew install --cask torbrowser

# less often
# brew install --cask disk-inventory-x
# brew install --cask screenflow
# brew install --cask vlc

brew cleanup
