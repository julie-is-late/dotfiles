#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Load profile
for file in "/etc/profile" "$HOME/.profile" "/etc/xprofile" "$HOME/.xprofile"; do
    if [ -f "$file" ]; then
        echo "Loading profile from $file";
        . "$file"
    fi
done

# Load resources
for file in "/etc/X11/Xresources"; do
    if [ -f "$file" ]; then
        echo "Loading resource: $file"
        xrdb -merge "$file"
    fi
done

if [ -f "$HOME/.Xresources" ]; then
    echo "Loading resource: $file"
    xrdb -merge "$file"
fi

# Load keymaps
for file in "/etc/X11/Xkbmap" "$HOME/.Xkbmap"; do
    if [ -f "$file" ]; then
        echo "Loading keymap: $file"
        setxkbmap `cat "$file"`
        XKB_IN_USE=yes
    fi
done

# Load xmodmap if not using XKB
if [ -z "$XKB_IN_USE" ]; then
    for file in "/etc/X11/Xmodmap" "$HOME/.Xmodmap"; do
        if [ -f "$file" ]; then
           echo "Loading modmap: $file"
           xmodmap "$file"
        fi
    done
fi

unset XKB_IN_USE

# Run all system xinitrc shell scripts
xinitdir="/etc/X11/xinit/xinitrc.d"
if [ -d "$xinitdir" ]; then
    for script in $xinitdir/*; do
        echo "Loading xinit script $script"
        if [ -x "$script" -a ! -d "$script" ]; then
            . "$script"
        fi
    done
fi

# Run user xsession shell script
script="$HOME/.xsession"
if [ -x "$script" -a ! -d "$script" ]; then
    echo "Loading xsession script $script"
    . "$script"
fi

export XDG_SESSION_TYPE=x11

# start keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# i just can't make up my damn mind
#exec gnome-session
exec i3
#exec cinnamon-session
