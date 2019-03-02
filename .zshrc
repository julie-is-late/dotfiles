#!/bin/zsh
# jshap's not-so-standard .zshrc

# -----------------------------------------
### zsh tweaks

autoload -U compinit
compinit

# history
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=5000

setopt sharehistory
setopt appendhistory

unsetopt beep

setopt interactive_comments     # allow in-repl comments starting w/ #

setopt completealiases          # complete alisases
setopt complete_in_word         # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much as it can until ambiguous
setopt auto_cd                  # auto cd when dir is given w/ no command
setopt correct                  # spelling correction for commands
setopt noflowcontrol            # turn off ctrl+s freezing, ctrl+q unfreezing
stty -ixon -ixoff 2>/dev/null   # no, really, please no flow control

# TODO: clean this section up/decide what's trash
#setopt hash_list_all    # hash everything before completion
#setopt always_to_end    # when compl. from middle of word, move cursor to end

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select                          # menu if nb items > 2
#zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
#zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# zsh moving
autoload -U zmv

# fix ctrl+w
autoload -U select-word-style
select-word-style bash


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

[[ -d ~/.zsh/functions ]] && for function in ~/.zsh/functions/*; do autoload -Uz $function ; done
[[ -d ~/.zsh/completion ]] && for function in ~/.zsh/completion/*; do autoload -Uz $function ; done

# local distro/machine specific config
local release=$(cat /etc/*release | awk -F'=' '/^ID=/ { print $2 }')
[[ -f "$HOME/.zsh/$release.zshrc" ]] && source "$HOME/.zsh/$release.zshrc"
[[ -f "$HOME/.zsh/$HOST.zshrc" ]] && source "$HOME/.zsh/$HOST.zshrc"
# work urls & servers
[[ -f "$HOME/.zsh/work.zshrc" ]] && source "$HOME/.zsh/work.zshrc"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# ssh-keys
local _ssh_env="$HOME/.ssh/environment-$HOST"
[[ -f "$_ssh_env" ]] && source $_ssh_env > /dev/null

#allow for ssh-add to be ctrl+c'd and yet still load my damn shell theme
local add-keys() {
    setopt localoptions localtraps
    trap 'return' INT
    ssh-add
}

# ensure it's alive and kicking
kill -0 ${SSH_AGENT_PID} >/dev/null 2>&1 || {
    (umask 066; ssh-agent -s | sed 's/^echo/#echo/' >! $_ssh_env)
    . $_ssh_env >/dev/null
    add-keys
}

# -----------------------------------------
### my (homeless) settings

# color theme tweaks
PURE_PROMPT_SYMBOL=">"
PURE_PROMPT_COLOR=6
PURE_CMD_MAX_EXEC_TIME=15
#PURE_PROMPT_HOST_COLOR=red
PURE_PROMPT_HOST_COLOR_MAX=6
PURE_PROMPT_HOST_COLOR_MIN=1
PURE_PROMPT_HOSTNAME="$HOST"

#[[ $TMUX = "" ]] || export TERM="${TERM/[a-zA-Z]+-?/screen}"


# -----------------------------------------
### plugin nonsense

# install if needed
if [ ! -x "$(command -v antibody)" ]; then
    if read "REPLY?antibody not found, would you like to install?: " && \
        { [[ ${REPLY} =~ "Y.*" ]] || [[ ${REPLY} =~ "y.*" ]]; }
    then
        local inst=$(mktemp)
        curl -sL "https://raw.githubusercontent.com/getantibody/installer/master/install" > $inst

        if read "REPLY?View the install script? or just fuck my shit up?: " && \
            { [[ ${REPLY} =~ "Y.*" ]] || [[ ${REPLY} =~ "y.*" ]]; }
        then
            vim $inst
        fi
        if read "REPLY?Proceed with install?: " && \
            { [[ ${REPLY} =~ "Y.*" ]] || [[ ${REPLY} =~ "y.*" ]]; }
        then
            sh $inst
        fi
    fi
fi

## load at end so setting variables take effect
source <(antibody init)

antibody bundle << EOF
# keyboard shortcuts bundle from oh-my-zsh
# other useful: archlinux colored-man-pages command-not-found docker git
robbyrussell/oh-my-zsh path:lib/key-bindings.zsh

# fzf shortcuts for **<tab> and ctrl+r
junegunn/fzf path:shell

# these completions are baller
zsh-users/zsh-completions path:src kind:fpath
# fish style syntax highlighting
zsh-users/zsh-syntax-highlighting

# and my theme
jshap70/pure path:async.zsh
jshap70/pure path:pure.zsh
EOF
