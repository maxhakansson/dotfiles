# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# history
SAVEHIST=100000

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

# Load Oh-My-Zsh library
zinit snippet OMZ::lib

# Load plugins
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Load Powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Tell zinit we're done
zinit cdreplay -q


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

# Load our dotfiles (sourced from former .bash_profile)
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file


# Zoxide (better cd)
eval "$(zoxide init zsh)"

# Fnm (Fast Node Manager)
eval "$(fnm env --use-on-cd)"

# Jenv (Java version manager)
eval "$(jenv init -)"

# Fzf specific config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Kepler SDK
#source /Users/mhakanss/.kepler/kntools/sdk/0.16.4/environment-setup-sdk.sh
