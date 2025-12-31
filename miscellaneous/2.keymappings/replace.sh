#!/usr/bin/env sh

TARGET="/etc/evremap.toml"
SOURCE="./evremap.toml"

# Check if target file already exists
if [ -f "$TARGET" ]; then
  echo "$TARGET already exists. Nothing to do."
  exit 0
fi

# Ensure source file exists
if [ ! -f "$SOURCE" ]; then
  echo "Source file $SOURCE not found."
  exit 1
fi

# Copy file and restart service
echo "Copying $SOURCE to $TARGET..."
sudo cp "$SOURCE" "$TARGET"

echo "Restarting evremap.service..."
sudo systemctl restart evremap.service

echo "Done."
