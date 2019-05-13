#!/bin/zsh
# jshap's pusheen custom zshrc

PURE_PROMPT_HOST_COLOR=cyan

alias reboot_to_windows='sudo bootctl set-oneshot windows && reboot'

if [[ -n $SSH_CLIENT ]]; then
    alias shutdown='sudo shutdown'
fi
