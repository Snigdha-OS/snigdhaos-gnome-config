#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx. This script configures resources and starts the GNOME desktop environment.

# Author		: Eshan Roy <m.eshanized@gmail.com>
# Author URL	: https://eshanized.github.io/

# Path to the user's X resources file
userresources="$HOME/.Xresources"
if [ -f "$userresources" ]; then
    # If the user's X resources file exists, load it
    xrdb -merge "$userresources"
    echo "Loaded user X resources from $userresources."
else
    # Log if the file is not found
    echo "User X resources file not found: $userresources."
fi

# Path to the user's custom key/mouse mapping configuration
usermodmap="$HOME/.Xmodmap"
if [ -f "$usermodmap" ]; then
    # If the user's .Xmodmap file exists, load it
    xmodmap "$usermodmap"
    echo "Loaded user key/mouse mappings from $usermodmap."
else
    # Log if the file is not found
    echo "User key/mouse mappings file not found: $usermodmap."
fi

# Path to system-wide X resources file
sysresources="/etc/X11/xinit/.Xresources"
if [ -f "$sysresources" ]; then
    # If the system-wide X resources file exists, load it
    xrdb -merge "$sysresources"
    echo "Loaded system X resources from $sysresources."
else
    # Log if the file is not found
    echo "System X resources file not found: $sysresources."
fi

# Path to system-wide key/mouse mapping file
sysmodmap="/etc/X11/xinit/.Xmodmap"
if [ -f "$sysmodmap" ]; then
    # If the system-wide .Xmodmap file exists, load it
    xmodmap "$sysmodmap"
    echo "Loaded system key/mouse mappings from $sysmodmap."
else
    # Log if the file is not found
    echo "System key/mouse mappings file not found: $sysmodmap."
fi

# Check if the directory /etc/X11/xinit/xinitrc.d exists
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    echo "Sourcing scripts in /etc/X11/xinit/xinitrc.d..."
    # Loop through all shell scripts in the directory
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        if [ -x "$f" ]; then
            # Source (execute in the current shell context) the script if it is executable
            . "$f"
            echo "Executed: $f"
        else
            # Log if the script is not executable
            echo "Skipped: $f (not executable)"
        fi
    done
    unset f
else
    # Log if the directory does not exist
    echo "Directory /etc/X11/xinit/xinitrc.d not found."
fi

# Set environment variables for X11 session
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
echo "Environment set: XDG_SESSION_TYPE=x11, GDK_BACKEND=x11."

# Start the GNOME desktop session
echo "Starting GNOME session..."
exec gnome-session  # Replace the current shell with the GNOME session process
