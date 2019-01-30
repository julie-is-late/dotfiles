#!/bin/zsh
# jshap's swordfish custom zshrc

function mousefix() {
    echo -n "none" | sudo tee /sys/bus/serio/devices/serio1/drvctl && \
    echo -n "reconnect" | sudo tee /sys/bus/serio/devices/serio1/drvctl && \
    libinput-gestures-setup restart
}
