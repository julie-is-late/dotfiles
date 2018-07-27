#!/bin/zsh
# jshap's bebop custom zshrc

### machine specific

export P4USER=jshapiro
#export P4PORT=p4sw.nvidia.com:2006
export P4PORT=p4proxy-austin.nvidia.com:2006
export P4CLIENT=jshapiro-lap-vi

export PURE_PROMPT_NO_FETCH="its slow"

#sync weechat
# sort -m -u logs/irc.マンガ.\#reddit-manga.weechatlog <(ssh shapirjr@192.168.0.4 cat \~/.weechat/logs/irc.マンガ.\#reddit-manga.weechatlog)> /tmp/kk

export ZPLUG_THREADS=2

#[[ $TMUX = "" ]] || export TERM="${TERM/[a-zA-Z]+-?/screen}"
#[[ $TMUX = "" ]] || export TERM="screen-256color"
#wsl mintty hack
#[[ $TERM = "screen-256color-italic" ]] && export TERM="xterm-256color"
[[ $TERM = "xterm" ]] && export TERM="xterm-256color"
[[ $SHELL = "/bin/bash" ]] && export SHELL="/usr/bin/zsh"

# build tool gems need to be in path
export PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin"
