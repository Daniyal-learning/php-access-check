#!/bin/bash

# Ensure the script runs with sudo privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Switching to sudo mode..."
    exec sudo bash "$0" "$@"
    exit
fi

# Directory where Nginx site configuration files are stored
CONFIG_DIR="/etc/nginx/sites-available"

# The line that should be present but not commented out
INCLUDE_LINE="include /etc/nginx/extras/wp_content_blocked.conf;"

echo "Checking for commented-out include lines..."

# Loop through all files in the directory
for file in "$CONFIG_DIR"/*; do
    # Check if it's a regular file
    if [ -f "$file" ]; then
        # Extract folder name (assuming structure: /etc/nginx/sites-available/site_name)
        FOLDER_NAME=$(basename "$file")
        
        # Check if the include line is present but commented out
        if grep -qE "^\s*#\s*$INCLUDE_LINE" "$file"; then
            echo "$FOLDER_NAME"
        fi
    fi
done
