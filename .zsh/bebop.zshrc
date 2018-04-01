#!/bin/zsh
## jshap's bebop custom zshrc

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
  export TERM=xterm-256color
fi
