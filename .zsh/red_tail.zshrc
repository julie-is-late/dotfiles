#!/bin/zsh
# jshap's bebop custom zshrc

export BROWSER=firefox-nightly

### machine specific
export P4USER=jshapiro
#export P4PORT=p4sw.nvidia.com:2006
export P4PORT=p4proxy-austin.nvidia.com:2006
export P4CLIENT=jshapiro-lap-vi

export P4DIFF="diff --color -u"
export P4MERGE=vimdiff
export P4IGNORE=$HOME/.p4ignore;

#export PATH=$PATH:~/d/sw/main/apps/p4review
alias p4review='~/d/sw/main/apps/p4review/p4review.pl'
alias p4rmerge='~/d/sw/main/apps/p4review/p4rmerge.pl'

# build tool gems need to be in path
#export PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin"
