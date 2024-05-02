#!/bin/sh

dconf load / < ~/.config/snigdhaos-gnome-config.ini
rm -f ~/.config/snigdhaos-gnome-config.ini ~/.config/autostart-scripts/dconf.sh &
 
notify-send "Snigdha OS Arctic V settings applied! 🔥"