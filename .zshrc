#!/bin/zsh
# jshap's not-so-standard .zshrc

# -----------------------------------------
### startup
#
# ~/.profile (sometimes /etc/zsh/zprofile doesn't load ~/.profile by default)
emulate sh -c 'source ~/.profile'

# -----------------------------------------
### zsh tweaks

autoload -U compinit
compinit

autoload -Uz promptinit

# history
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=5000

# import new commands from the history file also in other zsh-session
#setopt share_history
setopt append_history

# fuck you beep
unsetopt beep

setopt interactive_comments     # allow in-repl comments starting w/ #
setopt completeinword           # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much as it can until ambiguous
setopt auto_cd                  # auto cd when dir is given w/ no command
setopt correct                  # spelling correction for commands
setopt noflowcontrol            # turn off ctrl+s freezing, ctrl+q unfreezing
stty -ixon -ixoff 2>/dev/null   # no, really, please no flow control
setopt COMPLETE_ALIASES         # autocompletion of cli switches for aliases
setopt hash_list_all            # hash everything before completion

# completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
# case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# colorz!
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# describe completion type
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
# separate matches into groups
zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''
# menu if nb items > 2
zstyle ':completion:*' menu select
# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# set format for failing to match
#zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
## ???
#zstyle ':completion:*:messages'        format '%d'
#zstyle ':completion:*:options'         auto-description '%d'
## describe options in full
#zstyle ':completion:*:options'         description 'yes'
## provide verbose completion information
#zstyle ':completion:*'                 verbose true

# lifted from grml
zstyle -e ':completion:*' completer '
    if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
        _last_try="$HISTNO$BUFFER$CURSOR"
        reply=(_complete _match _ignored _prefix _files)
    else
        if [[ $words[1] == (rm|mv) ]] ; then
            reply=(_complete _files)
        else
            reply=(_oldlist _expand _complete _ignored _correct _approximate _files)
        fi
    fi'

# zsh moving
autoload -U zmv

# fix ctrl+w
autoload -U select-word-style
select-word-style bash

# -----------------------------------------
### load special dotfiles!

# my functions
fpath=(
    ~/.zsh/functions
    ~/.zsh/completion
    ~/.zsh/plugins
    ~/.zsh/plugins/pure
    "${fpath[@]}"
)

[[ -d ~/.zsh/functions ]] && for function in ~/.zsh/functions/*; do autoload -Uz $function ; done
[[ -d ~/.zsh/completion ]] && for function in ~/.zsh/completion/*; do autoload -Uz $function ; done

# local distro/machine specific config
local release=$(lsb_release -i -s 2>/dev/null | tr "[:upper:]" "[:lower:]")
if [[ -z "release" ]]; then
    release=$(awk -F'=' '/^ID=/ { print $2 }' /etc/*release | sed '1!d' | tr "[:upper:]" "[:lower:]")
fi
[[ -f "$HOME/.zsh/$release.zshrc" ]] && source "$HOME/.zsh/$release.zshrc"
[[ -f "$HOME/.zsh/$HOST.zshrc" ]] && source "$HOME/.zsh/$HOST.zshrc"
# work urls & servers
[[ -f "$HOME/.zsh/work.zshrc" ]] && source "$HOME/.zsh/work.zshrc"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# zsh profiling
function profile () {
    ZSH_PROFILE_RC=1 zsh "$@"
}


# -----------------------------------------
### ssh-keys

# if we already have a farwarded agent, do nothing
if [[ -z "$SSH_CONNECTION" ]]; then
    local _ssh_env="$HOME/.ssh/environment-$HOST"
    [[ -f "$_ssh_env" ]] && source $_ssh_env > /dev/null

    # allow for ssh-add to be ctrl+c'd and yet still load my damn shell theme
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
fi


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
#PURE_PROMPT_NO_FETCH=1

#[[ $TMUX = "" ]] || export TERM="${TERM/[a-zA-Z]+-?/screen}"


# -----------------------------------------
### plugin nonsense (some of the order matters)

# keyboard shortcuts bundle needs to be loaded first (from oh-my-zsh)
# other useful: archlinux colored-man-pages command-not-found docker git
#source "$HOME/.zsh/plugins/key-bindings.zsh"

# use antibody if needed
if [[ ! -a "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    # maybe install if needed
    if [ -z "$(command -v antibody)" ]; then
        if read "REPLY?antibody not found, would you like to install?: " && [[ ${REPLY:u} =~ "Y.*" ]]
        then
            local inst=$(mktemp)
            curl -sL "https://raw.githubusercontent.com/getantibody/installer/master/install" > $inst
            if read "REPLY?View the install script?: " && [[ "${REPLY:u}" =~ "Y.*" ]]
            then
                vim $inst
            fi
            if read "REPLY?Proceed with install? (and fuck my shit up): " && [[ "${REPLY:u}" =~ "Y.*" ]]
            then
                sh $inst
            fi
        fi
    fi
    if whence -cp antibody >/dev/null; then
        source <(antibody init)
        antibody bundle <<- EOF
        # fzf shortcuts for **<tab> and ctrl+r
        junegunn/fzf path:shell

        # these completions are baller
        zsh-users/zsh-completions path:src kind:fpath

        # fish style syntax highlighting
        zsh-users/zsh-syntax-highlighting
EOF
    fi
else # manually load some plugins :)
    # fish style syntax highlighting
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # better ctrl + r history searching
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi


# -----------------------------------------
### key bindings!
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

# search history from what's already typed
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Shift-Left]="${terminfo[kLFT]}"
key[Right]="${terminfo[kcuf1]}"
key[Shift-Right]="${terminfo[kRIT]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"          ]] && bindkey -- "${key[Home]}"          beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey -- "${key[End]}"           end-of-line
[[ -n "${key[Insert]}"        ]] && bindkey -- "${key[Insert]}"        overwrite-mode
[[ -n "${key[Backspace]}"     ]] && bindkey -- "${key[Backspace]}"     backward-delete-char
[[ -n "${key[Delete]}"        ]] && bindkey -- "${key[Delete]}"        delete-char
[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"            up-line-or-beginning-search
[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"          down-line-or-beginning-search
[[ -n "${key[Left]}"          ]] && bindkey -- "${key[Left]}"          backward-char
[[ -n "${key[Shift-Left]}"    ]] && bindkey -- "${key[Shift-Left]}"    backward-char
[[ -n "${key[Right]}"         ]] && bindkey -- "${key[Right]}"         forward-char
[[ -n "${key[Shift-Right]}"   ]] && bindkey -- "${key[Shift-Right]}"   forward-char
[[ -n "${key[PageUp]}"        ]] && bindkey -- "${key[PageUp]}"        beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey -- "${key[PageDown]}"      end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"     ]] && bindkey -- "${key[Shift-Tab]}"     reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# -----------------------------------------
# and finally: load my theme!
source "$HOME/.zsh/plugins/pure/async.zsh"

promptinit
prompt pure
