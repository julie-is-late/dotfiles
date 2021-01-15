#!/bin/zsh
# jshap's shoujo custom zshrc

alias reboot_to_windows='sudo bootctl set-oneshot windows.conf && reboot'

if [[ -n $SSH_CLIENT ]]; then
    alias shutdown='sudo shutdown'
fi
