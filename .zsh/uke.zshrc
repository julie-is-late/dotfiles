#!/bin/zsh
# misc completion
compdef downgrade

# make gpg headless compatible
export GPG_TTY=$(tty)

if [[ -n $SSH_CLIENT ]]; then
    alias reboot='sudo reboot'
    alias shutdown='sudo shutdown'
fi
