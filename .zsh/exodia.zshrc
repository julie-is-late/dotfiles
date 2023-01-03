#!/bin/zsh
# jshap's pusheen custom zshrc

PURE_PROMPT_HOST_COLOR=cyan

# perforce
export P4CLIENT=jshapiro-dev-exo

alias reboot_to_windows="sudo bootctl set-oneshot windows.conf && sudo reboot"
#alias reboot_to_windows="sudo efibootmgr --bootnext 0000 && reboot"

if [[ -n $SSH_CLIENT ]]; then
    alias shutdown='sudo shutdown'
fi
