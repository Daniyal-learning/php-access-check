#!/bin/bash

# Directory where Nginx site configuration files are stored
CONFIG_DIR="/etc/nginx/sites-available"

# The line that should be present but not commented out
INCLUDE_LINE="include /etc/nginx/extras/wp_content_blocked.conf;"

sudo echo "Checking for commented-out include lines..."

# Loop through all files in the directory
for file in $(sudo ls -1 "$CONFIG_DIR"); do
    # Construct full file path
    FILE_PATH="$CONFIG_DIR/$file"

    # Check if it's a regular file
    if sudo [ -f "$FILE_PATH" ]; then
        # Extract folder name (assuming structure: /etc/nginx/sites-available/site_name)
        FOLDER_NAME=$(basename "$FILE_PATH")
        
        # Check if the include line is present but commented out
        if sudo grep -qE "^\s*#\s*$INCLUDE_LINE" "$FILE_PATH"; then
            sudo echo "$FOLDER_NAME"
        fi
    fi
done
