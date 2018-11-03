#!/bin/zsh
# jshap's shoujo custom zshrc

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
  export TERM=xterm-256color
fi

alias reboot_to_windows='sudo efibootmgr --bootnext 0000 && reboot'
