#!/bin/zsh
# jshap's not-so-standard .zshrc


# -----------------------------------------
### zplug nonsense

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug --self-manage
fi

# load zplug
source ~/.zplug/init.zsh
# manage yourself 
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# bundles from oh-my-zsh
# other useful: archlinux golang gradle colored-man-pages command-not-found
#               docker thefuck pip git
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "lib/key-bindings", \
    from:oh-my-zsh
[ -x "$(command -v fzf)" ] && [[ "$(command -v fzf)" != $ZPLUG_BIN* ]] || \
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"
zplug "junegunn/fzf", \
    rename-to:fzf-zsh, \
    use:"shell/*.zsh", \
    defer:2
#    on:"fzf-bin"
zplug "zsh-users/zsh-completions", defer:2
# lets get some syntax highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# and my theme
zplug "mafredri/zsh-async", use:"async.zsh"
zplug "jshap70/pure", use:"pure.zsh", as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# -----------------------------------------
### zsh tweaks

# history
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=5000
setopt sharehistory
setopt appendhistory

unsetopt beep

setopt INTERACTIVE_COMMENTS     # allow in-repl comments starting w/ #

setopt completealiases          # complete alisases
setopt complete_in_word         # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much as it can until ambiguous
setopt auto_cd                  # auto cd when dir is given w/ no command

setopt noflowcontrol          # turn off ctrl+s freezing, ctrl+q unfreezing
stty -ixon -ixoff 2>/dev/null # no, really, please no flow control

# TODO: clean this section up/decide what's trash

#setopt hash_list_all    # hash everything before completion
#setopt always_to_end    # when compl. from middle of word, move cursor to end
#setopt correct          # spelling correction for commands

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
zstyle ':completion:*' rehash true
#zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
#zstyle ':completion:*' menu select                          # menu if nb items > 2
#zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use
#zstyle ':completion:*' menu select

# zsh moving
autoload -U zmv

# fix ctrl+w
autoload -U select-word-style
select-word-style bash

export PATH=$PATH:~/.zplug/bin

# load zplug @ the end


# -----------------------------------------
### load special dotfiles!

# ~/.profile (sometimes /etc/zsh/zprofile doesn't load ~/.profile by default)
emulate sh -c 'source ~/.profile'

# my functions
fpath=(
    ~/.zsh/functions
    ~/.zsh/completion
    "${fpath[@]}"
)
for function in ~/.zsh/functions/*; do autoload -Uz $function ; done
for function in ~/.zsh/completion/*; do autoload -Uz $function ; done

# local distro/machine specific config
local release=$(cat /etc/*release | awk -F'=' '/^ID=/ { print $2 }')
[[ -f "$HOME/.zsh/$release.zshrc" ]] && source "$HOME/.zsh/$release.zshrc"
local host=$HOST
[[ -f "$HOME/.zsh/$host.zshrc" ]] && source "$HOME/.zsh/$host.zshrc"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# add custom completions
zstyle :compinstall filename "$HOME/.zshrc"


# -----------------------------------------
### my (homeless) settings

# color theme tweaks
PURE_PROMPT_SYMBOL=">"
PURE_PROMPT_COLOR=6
PURE_CMD_MAX_EXEC_TIME=15
#PURE_PROMPT_HOST_COLOR=red
PURE_PROMPT_HOSTNAME="$host"


#[[ $TMUX = "" ]] || export TERM="${TERM/[a-zA-Z]+-?/screen}"

# -----------------------------------------
### load zplug

# NOTE: here so custom theme variables take effect
zplug load # finish zplug
