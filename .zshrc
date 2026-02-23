
# Load our dotfiles (sourced from former .bash_profile)
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# history
SAVEHIST=1000000
HISTSIZE=1000000
HISTFILE=~/.zsh_history

# Enhanced history configuration
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicates first
setopt HIST_IGNORE_DUPS         # Don't record duplicate entries
setopt HIST_IGNORE_SPACE        # Don't record commands starting with space
setopt HIST_VERIFY              # Show before executing from history
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks

# Zinit setup - modern zsh plugin manager
# Install zinit if not already installed
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load Powerlevel10k theme first (unless Starship is enabled)
if [[ "$STARSHIP_ENABLED" != "1" ]]; then
  zinit ice depth=1; zinit light romkatv/powerlevel10k
fi

# Load plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Load git plugin from Oh-My-Zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Initialize completion system (required before fzf-tab)
autoload -Uz compinit
compinit

# Load fzf-tab AFTER compinit
zinit light Aloxaf/fzf-tab                    # Replace tab completion with fzf

# History substring search
zinit light zsh-users/zsh-history-substring-search

# Bind keys for history substring search
bindkey '^[[A' history-substring-search-up     # Up arrow
bindkey '^[[B' history-substring-search-down   # Down arrow


# Automatically list directory contents on `cd`.
auto-ls () {
	emulate -L zsh;
	# explicit sexy ls'ing as aliases arent honored in here.
	hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}
chpwd_functions=( auto-ls $chpwd_functions )


# history mgmt
# http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/
setopt inc_append_history
setopt share_history

# Additional zsh options for better navigation
setopt AUTO_PUSHD           # Push directories to stack automatically
setopt PUSHD_IGNORE_DUPS    # Don't push duplicate directories
setopt PUSHD_SILENT         # Don't print directory stack after pushd/popd

# Completion caching for faster startup
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Better completion formatting
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# Zoxide (better cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Fnm (Fast Node Manager)
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

# Jenv (Java version manager)
if command -v jenv &> /dev/null; then
  eval "$(jenv init -)"
fi

# Atuin (magical shell history)
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# Direnv (auto-load environment variables)
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# Fzf specific config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship prompt (alternative to p10k - set STARSHIP_ENABLED=1 to use)
if [[ "$STARSHIP_ENABLED" == "1" ]] && command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  # Default: Use Powerlevel10k
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
