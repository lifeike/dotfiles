#!/bin/bash

# Define paths
SOURCE_FILE="{{ .chezmoi.sourceDir }}/evremap.toml"
TARGET_FILE="/etc/evremap.toml"

# 1. Check if the file exists in /etc
if [ ! -f "$TARGET_FILE" ]; then
    echo "Creating $TARGET_FILE..."
    
    # 2. Copy the file (using sudo since /etc is root-owned)
    # We assume your evremap.toml is stored in your chezmoi source dir
    sudo cp "$SOURCE_FILE" "$TARGET_FILE"
    sudo chmod 644 "$TARGET_FILE"

    # 3. Restart the service
    echo "Restarting evremap service..."
    sudo systemctl restart evremap.service
else
    echo "Configuration already exists at $TARGET_FILE. Skipping copy."
fi
