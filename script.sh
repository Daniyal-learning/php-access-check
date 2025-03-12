#!/bin/bash

CONFIG_DIR="/etc/nginx/sites-available"

INCLUDE_LINE="include /etc/nginx/extras/wp_content_blocked.conf;"

echo "Checking for commented-out include lines..."

for file in "$CONFIG_DIR"/*; do
    # Check if it's a regular file
    if [ -f "$file" ]; then
        FOLDER_NAME=$(basename "$file")
        
        if grep -qE "^\s*#\s*$INCLUDE_LINE" "$file"; then
            echo "$FOLDER_NAME"
        fi
    fi
done
