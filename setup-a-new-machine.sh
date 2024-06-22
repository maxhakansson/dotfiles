# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1


##############################################################################################################
###  backup old machine's key items

mkdir -p ~/migration/home
cd ~/migration

# what is worth reinstalling?
brew leaves           > brew-list.txt    # all top-level brew installs
brew list --cask      > cask-list.txt
npm list -g --depth=0 > npm-g-list.txt


# then compare brew-list to what's in `brew.sh`
#   comm <(sort brew-list.txt) <(sort brew.sh-cleaned-up)

# let's hold on to these

cp ~/.extra ~/migration/home
cp ~/.z ~/migration/home

cp -R ~/.ssh ~/migration/home
cp -R ~/.gnupg ~/migration/home

cp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/migration  # wifi

cp ~/Library/Preferences/net.limechat.LimeChat.plist ~/migration
cp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration

cp -R ~/Library/Services ~/migration # automator stuff

cp -R ~/Documents ~/migration

cp ~/.bash_history ~/migration # back it up for fun?

cp ~/.gitconfig.local ~/migration

cp ~/.z ~/migration # z history file.

# sublime text settings
cp "~/Library/Application Support/Sublime Text 3/Packages" ~/migration


# iTerm settings.
  # Prefs, General, Use settings from Folder

# Finder settings and TotalFinder settings
#   Not sure how to do this yet. Really want to.

# Timestats chrome extension stats
#   chrome-extension://ejifodhjoeeenihgfpjijjmpomaphmah/options.html#_options
# 	gotta export into JSON through devtools:
#     copy(JSON.stringify(localStorage, null, '  '))
#     pbpaste > timestats-canary.json.txt

# Current Chrome tabs via OneTab

# software licenses like sublimetext


### end of old machine backup
##############################################################################################################



##############################################################################################################
### XCode Command Line Tools
#      thx https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

xcode-select --print-path &> /dev/null

##############################################################################################################



##############################################################################################################
### homebrew!

# (if your machine has /usr/local locked down (like google's), you can do this to place everything in ~/.homebrew
mkdir $HOME/.homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $HOME/.homebrew
export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH

# install all the things
./brew.sh
./brew-cask.sh

### end of homebrew
##############################################################################################################




##############################################################################################################
### install of common things
###
mkdir "${HOME}/.npm-packages"
mkdir "${HOME}/.npm-packages/lib"

# trash as the safe `rm` alternative
npm install -g trash-cli


# antigen
curl -L git.io/antigen > ~/code/antigen.zsh

###
##############################################################################################################



##############################################################################################################
### remaining configuration
###

# go read mathias, paulmillr, gf3, alraa's dotfiles to see what's worth stealing.

# prezto and antigen communties also have great stuff
#   github.com/sorin-ionescu/prezto/blob/master/modules/utility/init.zsh

# set up macOS defaults
#   maybe something else in here https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
./macos.sh


##############################################################################################################
### symlinks to link dotfiles into ~/
###

#   move git credentials into ~/.gitconfig.local    	http://stackoverflow.com/a/13615531/89484
#   now .gitconfig can be shared across all machines and only the .local changes

# symlink it up!
./symlink-setup.sh

# add manual symlink for .ssh/config and probably .config/fish

###
##############################################################################################################
