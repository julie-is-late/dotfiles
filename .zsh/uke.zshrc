#!/bin/zsh
# jshap's pi's custom zshrc

# add reminder that shutdowns require hardware intervention
function shutdown() {
    if read "REPLY?WARNING: Shutdown requires hardware intervention. Continue?: " && \
        { [[ ${REPLY} =~ "Y.*" ]] || [[ ${REPLY} =~ "y.*" ]]; }
        then
            exec /usr/bin/shutdown $@
        fi
    echo "Maybe you meant reboot?"
}
