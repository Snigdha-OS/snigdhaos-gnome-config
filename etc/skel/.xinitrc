#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx. Configures resources and launches the window manager or desktop environment.

# Author		: Eshan Roy <m.eshanized@gmail.com>
# Author URL	: https://eshanized.github.io/

# Load user-specific X resources
userresources="$HOME/.Xresources"
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
    echo "Loaded user X resources from $userresources."
else
    echo "User X resources file not found: $userresources."
fi

# Load user-specific keyboard or pointer mappings
usermodmap="$HOME/.Xmodmap"
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
    echo "Loaded user key/mouse mappings from $usermodmap."
else
    echo "User key/mouse mappings file not found: $usermodmap."
fi

# Load system-wide X resources
sysresources="/etc/X11/xinit/.Xresources"
if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
    echo "Loaded system X resources from $sysresources."
else
    echo "System X resources file not found: $sysresources."
fi

# Load system-wide keyboard or pointer mappings
sysmodmap="/etc/X11/xinit/.Xmodmap"
if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
    echo "Loaded system key/mouse mappings from $sysmodmap."
else
    echo "System key/mouse mappings file not found: $sysmodmap."
fi

# Source scripts from /etc/X11/xinit/xinitrc.d, if the directory exists
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    echo "Sourcing scripts in /etc/X11/xinit/xinitrc.d..."
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        if [ -x "$f" ]; then
            . "$f"
            echo "Executed: $f"
        else
            echo "Skipped: $f (not executable)"
        fi
    done
    unset f
else
    echo "Directory /etc/X11/xinit/xinitrc.d not found."
fi

# Export session type as X11 for compatibility
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
echo "Environment set: XDG_SESSION_TYPE=x11, GDK_BACKEND=x11."

# Start the GNOME session
echo "Starting GNOME session..."
exec gnome-session
