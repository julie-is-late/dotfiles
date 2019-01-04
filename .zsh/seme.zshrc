#!/bin/zsh
# jshap's shoujo custom zshrc

alias reboot_to_windows='sudo efibootmgr --bootnext 0000 && reboot'

if [[ -n $SSH_CLIENT ]]; then
    alias shutdown='sudo shutdown'
fi
