#!/bin/zsh
# jshap's ubuntu custom zshrc

### distro specific

alias reboot='sudo reboot'
alias shutdown='sudo shutdown'
alias tmux=tmux-next

function pacaur() {
    sudo apt update
    sudo apt list --upgradable
    sudo apt upgrade
}

compdef mosh=ssh
compdef _tmux tmux-next

export P4DIFF="colordiff -u"
export P4MERGE=vimdiff

export P4IGNORE=$HOME/.p4ignore;

#export PATH=$PATH:~/d/sw/main/apps/p4review
alias p4review='~/d/sw/main/apps/p4review/p4review.pl'
alias p4rmerge='~/d/sw/main/apps/p4review/p4rmerge.pl'

function p4-opened() {
    # sort by default vs change then by cl# & tabulate
    p4 opened $@ | sort -b -k5,5 -k1,3 | sed "s@"${$(pwd)##$HOME/d/}"@...@" | column -t
}

function p4-status() {
    # sort by default vs change then by cl# & tabulate
    #p4 status | sort -k4,5 | column -t
    #p4 status | sort -k4,5 | awk 'BEGIN { OFS="," } { print $1,$3" "$4" "$5,$(NF-1),$NF }' | column -ts','
    p4 status | sort -k4,5 | awk 'BEGIN { OFS="," } { if ($3=="reconcile") { print $1,$3" "$4," ",$5,$6 } else if ($3=="submit") { print $1,$3" "$4,$5,$7,$8 } else { print } }' | column -ts','
}

