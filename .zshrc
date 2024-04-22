# uncomment to profile prompt startup with zprof
# zmodload zsh/zprof

# history
SAVEHIST=100000

# vim bindings
bindkey -v

fpath=( "$HOME/.zfunctions" $fpath )


# antigen time!
source ~/code/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
# antigen bundle git
# antigen bundle command-not-found
# antigen bundle osx
# antigen bundle docker

# Load bundles from external repos
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
# antigen theme denysdovhan/spaceship-prompt
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply


export PURE_GIT_UNTRACKED_DIRTY=0

# Automatically list directory contents on `cd`.
auto-ls () {
	emulate -L zsh;
	# explicit sexy ls'ing as aliases arent honored in here.
	hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}
chpwd_functions=( auto-ls $chpwd_functions )


# Enable autosuggestions automatically
# zle-line-init() {
#     zle autosuggest-start
# }

# zle -N zle-line-init


# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history


# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# uncomment to finish profiling
# zprof

export NVM_DIR="$HOME/.nvm"
[ -s "$HOME/.homebrew/opt/nvm/nvm.sh" ] && \. "$HOME/.homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$HOME/.homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOME/.homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Load default dotfiles
source ~/.bash_profile

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Zoxide (better cd)
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

