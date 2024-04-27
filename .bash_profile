# Load our dotfiles like ~/.bash_prompt, etc…
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

if [[ -n "$ZSH_VERSION" ]]; then  # quit now if in zsh
    return 1 2> /dev/null || exit 1;
fi;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    # Ensure existing Homebrew v1 completions continue to work
    export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;
