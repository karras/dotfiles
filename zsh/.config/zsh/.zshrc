
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

# Adjust word detection to make sure ALT + Backspace only deletes up to the
# next slash
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

############################
# History
############################

HISTFILE=~/.local/share/histfile
HISTSIZE=10000
SAVEHIST=10000

############################
# Completion
############################

# Compinstall file path
zstyle :compinstall filename '~/.config/zsh/.zshrc'

# Do not insert actual tabs
zstyle ':completion:*' insert-tab false

# Load completion
autoload -Uz compinit && compinit

############################
# Prompt
############################

# Load VCS info
autoload -Uz vcs_info

# Load fancy colors
autoload -Uz colors && colors

# Enable prompt substitution
setopt prompt_subst

# Only enable VCS tracking for git
zstyle ':vcs_info:*' enable git
# Update VCS prompt with each change, potentially slow in large repos
zstyle ':vcs_info:*' check-for-changes true

# String to display when repo contains unstaged changes
zstyle ':vcs_info:git*' unstagedstr '|%F{yellow}U%f'
# String to display when repo contains staged changes
zstyle ':vcs_info:git*' stagedstr '|%F{yellow}S%f'
# Disable patch information that would otherwise lead to information overload in %m
zstyle ':vcs_info:git*' patch-format ''
zstyle ':vcs_info:git*' nopatch-format ''

# General format for vcs_info prompt
# %b = Branch string 
# %m = Differences to upstream HEAD
# %u = Unstaged string
# %u = Staged string
zstyle ':vcs_info:git*' formats ' %F{green}[%b%f%m%u%c%F{green}]%f'

# Adjust vcs_info prompt slightly when in action (e.g. rebasing)
# %a = Action string
zstyle ':vcs_info:git*' actionformats ' %F{green}[%b%f%m%u%c%F{green}]%f %F{red}(%a)%f'

# Hook to add some additional fancy information to vcs_info prompt
# Show '+N|-N' when local branch is ahead-of or behind remote HEAD
# Show 'T' when working directory contains untracked files
# Kudos to https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Check if untracked files in working dir
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
        hook_com[staged]+='%F{white}|%f%F{yellow}T%f'
    fi

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    # Check for differences between remote HEAD
    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "|%F{green}+${ahead}%f" )
    (( $behind )) && gitstatus+=( "|%F{red}-${behind}%f" )

    hook_com[misc]+="${(j::)gitstatus}"
}

precmd() {
    vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # Define prompt if not a git repository
        # Scheme: '$USER@$HOSTNAME $PWD [$GIT_BRANCH] $ '
        PROMPT='%{$fg[blue]%}%n%{$reset_color%}@%m %{$fg[yellow]%}%1~%{$reset_color%} %{$fg[blue]%}%#%{$reset_color%} '

    else
        # Define prompt if a git repository
        # Scheme: '$USER@$HOSTNAME $PWD [$GIT_BRANCH] $ '
        PROMPT='%{$fg[blue]%}%n%{$reset_color%}@%m %{$fg[yellow]%}%1~%{$reset_color%}${vcs_info_msg_0_} %{$fg[blue]%}%#%{$reset_color%} '
    fi
}

############################
# Aliases
############################

alias ll='ls -al'
alias vi='nvim'
alias vim='nvim'

############################
# Exports
############################

# Pinentry curses/TTY
export GPG_TTY=$(tty)

############################
# SSH Agent
############################

# Initialize ssh-agent if not running already
if ! ps -C ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/*.key
    echo "$SSH_AUTH_SOCK" > ~/.config/ssh_agent_env
else
    export SSH_AUTH_SOCK="$(< ~/.config/ssh_agent_env)"
fi
