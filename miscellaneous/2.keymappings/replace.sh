#!/usr/bin/env sh

# 1. sudo evremap list-devices to find keyboard device
# 2. put the device name in the home.tmol or office.tmol file
# 3. set home.tmol or office.tmol file as the source file
SOURCE="./evremap.toml"
# 4. run this script to replace /etc/evremap.toml file with home or office.tmol file 
TARGET="/etc/evremap.toml"

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
