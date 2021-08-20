
############################
# History
############################

HISTFILE=~/.local/share/histfile
HISTSIZE=10000
SAVEHIST=10000

############################
# General
############################

# Disable automatically switching into directories
unsetopt autocd 
# Disable beeps
unsetopt beep

# Emacs mode
bindkey -e

# Allow jumping between words with CTRL + arrow keys
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# Only delete chars backwards with CTRL + U instead of whole line
bindkey "^U" backward-kill-line

# Compinstall file path
zstyle :compinstall filename '~/.config/zsh/.zshrc'

# Do not insert actual tabs
zstyle ':completion:*' insert-tab false

# Load completion
autoload -Uz compinit
compinit

############################
# Aliases
############################

alias ll='ls -al'
alias vi='nvim'
alias vim='nvim'

############################
# Exports
############################

# Less history file path, does not like the tilde symbols
export LESSHISTFILE="$HOME/.local/share/lesshistfile"

#export GPG_TTY=$(tty)

