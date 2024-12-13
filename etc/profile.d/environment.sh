#!/bin/bash
# Description: Configures environment variables for Wayland and Qt applications.
# Author		: Eshan Roy <m.eshanized@gmail.com>
# Author URL	: https://eshanized.github.io/

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Log the start of the script
log_message "Starting environment configuration script..."

# Check if the session type is Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    log_message "Wayland session detected."

    # Set the Qt platform to Wayland
    export QT_QPA_PLATFORM=wayland
    log_message "Set QT_QPA_PLATFORM to 'wayland'."

    # Enable Wayland support for Mozilla applications
    export MOZ_ENABLE_WAYLAND=1
    log_message "Enabled Wayland support for Mozilla applications (MOZ_ENABLE_WAYLAND=1)."
else
    log_message "Non-Wayland session detected. No Wayland-specific variables set."
fi

# Set a custom Qt style engine to Kvantum
export QT_STYLE_OVERRIDE=kvantum
log_message "Set QT_STYLE_OVERRIDE to 'kvantum'."

# Verify environment variable settings
log_message "Verifying environment variables..."
log_message "QT_QPA_PLATFORM=${QT_QPA_PLATFORM:-not set}"
log_message "MOZ_ENABLE_WAYLAND=${MOZ_ENABLE_WAYLAND:-not set}"
log_message "QT_STYLE_OVERRIDE=${QT_STYLE_OVERRIDE:-not set}"

# Log the end of the script
log_message "Environment configuration script completed."
