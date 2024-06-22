#!/bin/sh

brew install "lotyp/formulae/dockutil"

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Launchpad.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"

killall Dock

brew uninstall "dockutil"
