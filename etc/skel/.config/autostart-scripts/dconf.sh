#!/bin/sh
# 
# Script to apply GNOME settings using dconf and clean up temporary files
#

# Apply GNOME settings from a custom dconf configuration file
dconf load / < ~/.config/snigdhaos-gnome-config.ini
# Explanation:
#   - `dconf load /` applies settings under the root path of dconf.
#   - The input is redirected from the file `~/.config/snigdhaos-gnome-config.ini`,
#     which contains pre-configured GNOME settings in dconf dump format.

# Remove temporary configuration and autostart script files after applying settings
rm -f ~/.config/snigdhaos-gnome-config.ini ~/.config/autostart-scripts/dconf.sh &
# Explanation:
#   - `rm -f` forcefully removes the specified files without prompting.
#   - The `&` at the end runs this command in the background, allowing the script to proceed without waiting.

# Send a desktop notification to indicate the successful application of settings
notify-send "Snigdha OS Arctic V settings applied! 🔥"
# Explanation:
#   - `notify-send` displays a system notification with the specified message.
#   - This informs the user that the script has finished applying settings.

# End of script
