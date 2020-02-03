#!/bin/zsh
# jshap's lizard-knight profile

# perforce
export P4CLIENT=jshapiro-dev-il

# specify directory colors
eval $(dircolors -b ~/.dir_colors)

function get_title() {
    tmux list-windows | awk '$NF ~ /active/ {gsub(/\*/, ""); print $2}'
}

function set_title() {
    # TODO: maybe fix this to use `tmux rename-window -t${TMUX_PANE} "$@"` instead
    #       would need to make sure it is properly inside a zsh session first though
    printf "\033k${@}\033\\"
}

function relocate() {
    original="$1" target="$2"
    if [ -d "$target" ]; then
        target="$target/${original##*/}"
    fi
    mv -- "$original" "$target"
    ln -s -- "$target" "$original"

}


# add cuda to path if it's not there already
export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64

# unix-build path
export PATH=$PATH:/sw/misc/linux

# tmp(?)
export PATH=$PATH:/usr/local/cmake/bin
export PATH=$PATH:/usr/local/openmpi/bin

function reboot_to_windows() {
    echo "rebooting to windows, press any key to confirm"
    read -k1 -s
    sudo grub-reboot 0
    sudo reboot
}

function cuda-v() {
    echo $(nvcc -V | awk '/release/ { print $6 }')
}

function cuda-loc() {
    ll /usr/local/cuda | awk '{ print $NF }' 
}

function driver-v() {
    echo $(nvidia-installer -v | awk '/version / { print $3 }')
}

function sm-v() {
    echo $(checkGPU | awk '{ print $(NF) }')
}

function gpu-v() {
    echo $(checkgpu | grep -o "Dev name: '.*'" | sed "s/Dev name: '//; s/'//; s/ /_/g")
}

alias nvidia-smh='nvidia-smi'
