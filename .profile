# jshap's not-so-standard .profile

# -----------------------------------------
# environment settings

export EDITOR="vim"
export BROWSER="firefox-nightly"
export TERMINAL="alacritty"

# LS_COLORS are nice :)
if [ -f "$HOME/.dir_colors" ]; then
    eval "$(dircolors -b ~/.dir_colors)"
else
    # don't require stat for permisions check on every ls
    eval "$(dircolors -p | perl -pe 's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | dircolors -)"
fi
#eval $(dircolors -b ~/.dir_colors)

# do a bunch of less config stuffs...
# like, don't ring the bell at EOF in less. it's annoying.
# e = quit on 2x eof
# F = tail
# i = ignore search case
# Q = quiet / nobell
# R = color / nostrip
# X = leave output on terminal
# N = line numbers
# S = chop long lines
# M = more
# K = quit on sigint
export LESS="-FiQRX"
export SYSTEMD_LESS="-FRSXMKQi"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
       . "$HOME/.bashrc"
    fi
fi


# -----------------------------------------
# path

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi

# frameworks:

# go
export GOPATH="$HOME/.cache/go"

# programs:

# android
#export ANDROID_HOME=/opt/android-sdk
#export PATH="$PATH:$ANDROID_HOME/tools"
#export PATH="$PATH:$ANDROID_HOME/platform-tools"

# idea
#export PATH="$PATH:/home/shapirjr/bin/intellij/bin"


# -----------------------------------------
# misc tweaks/fixes

# GTK - https://wiki.archlinux.org/index.php/GTK%2B#Suppress_warning_about_accessibility_bus
export NO_AT_BRIDGE=1

# enable firefox on wayland
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND=wayland
fi
