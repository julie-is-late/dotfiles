# jshap's not-so-standard .profile

# -----------------------------------------
# environment settings

export EDITOR="vim"
export BROWSER="firefox-nightly"

# specify directory colors
#eval $(dircolors -b ~/.dir_colors)

# don't ring the bell at EOF in less. it's annoying.
export LESS="$LESS -eFRXQ"

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
#export GOBIN="~/go/bin"
#export GOPATH="~/go"
#export PATH="$PATH:$GOPATH/bin"

# ruby gems
#export PATH="$PATH:/home/shapirjr/.gem/ruby/2.4.0/bin"

# gradle
#export GRADLE_HOME="~/bin/gradle"
#export PATH="$PATH:$GRADLE_HOME/bin"

# programs:
# android
#export ANDROID_HOME=/opt/android-sdk
#export PATH="$PATH:$ANDROID_HOME/tools"
#export PATH="$PATH:$ANDROID_HOME/platform-tools"

# idea
#export PATH="$PATH:/home/shapirjr/bin/intellij/bin"

# misc
#export PATH="$PATH:~/bin/matlab"
#export PATH="$PATH:~/bin/matlab/bin"
#export PATH="$PATH:~/bin/rabbitmq_server/sbin/"
#export PATH="$PATH:~/bin/neo4j-community/bin"

# added by Anaconda3 4.1.1 installer
#export PATH="/home/shapirjr/anaconda3/bin:$PATH"


# -----------------------------------------
# misc tweaks/fixes

# GTK - https://wiki.archlinux.org/index.php/GTK%2B#Suppress_warning_about_accessibility_bus
export NO_AT_BRIDGE=1

