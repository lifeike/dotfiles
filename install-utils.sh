#!/bin/bash

# install-utils.sh - Reusable utility functions for package installation

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo ""
    echo "##############################################"
    echo "$1"
    echo "##############################################"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if apt package is installed
package_installed() {
    dpkg -l "$1" 2>/dev/null | grep -q "^ii"
}

# Function to check if snap package is installed
snap_installed() {
    snap list "$1" >/dev/null 2>&1
}

# Function to install apt package if not installed
install_apt() {
    local package=$1
    if package_installed "$package"; then
        echo -e "${GREEN}✓${NC} $package is already installed"
    else
        echo -e "${YELLOW}→${NC} Installing $package..."
        sudo apt install -y "$package"
    fi
}

# Function to install snap package if not installed
install_snap() {
    local package=$1
    local flags=${2:-""}
    if snap_installed "$package"; then
        echo -e "${GREEN}✓${NC} $package is already installed"
    else
        echo -e "${YELLOW}→${NC} Installing $package via snap..."
        sudo snap install $flags "$package" --classic
    fi
}

# Function to install pip package if not installed
install_pip() {
    local package=$1
    local install_cmd=${2:-"pipx install $package"}  # default install command

    # Check if the package is already installed via pipx
    if pipx list | grep -q " $package "; then
        echo -e "${GREEN}✓${NC} $package is already installed via pipx"
    else
        echo -e "${YELLOW}→${NC} Installing $package via pipx..."
        eval "$install_cmd"
    fi
}

# Function to install npm global package if not installed
install_npm_global() {
    local package=$1
    if npm list -g "$package" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $package is already installed globally"
    else
        echo -e "${YELLOW}→${NC} Installing $package globally via npm..."
        sudo npm install -g "$package"
    fi
}

# Function to setup passwordless sudo
setup_passwordless_sudo() {
    if sudo grep -Fxq "$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers; then
        echo -e "${GREEN}✓${NC} User already has passwordless sudo access"
    else
        echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
    fi
}

# Function to perform system update
system_update() {
    print_header "System Update"
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt-get update -y
    sudo apt-get upgrade -y
}

# Function to install a .deb package from URL
install_deb_from_url() {
    local url=$1
    local package_name=$2
    
    echo -e "${YELLOW}→${NC} Installing $package_name..."
    local filename=$(basename "$url")
    curl -LO "$url"
    sudo dpkg -i "$filename"
    rm "$filename"
}

# Function to add user to a group
add_user_to_group() {
    local group=$1
    local user=${2:-$USER}
    
    if groups $user | grep -q "\\b$group\\b"; then
        echo -e "${GREEN}✓${NC} User $user is already in the $group group"
    else
        echo -e "${YELLOW}→${NC} Adding user $user to $group group..."
        sudo usermod -aG $group $user
        echo -e "${YELLOW}!${NC} Log out and back in, or run: newgrp $group"
    fi
}

# Function to cleanup system
cleanup_system() {
    print_header "Cleanup"
    sudo fc-cache -fv
    sudo apt clean -y
    sudo apt autoremove -y
    sudo apt autoclean -y
}

# Function to load configuration files
load_configs() {
    print_header "Loading Configuration Files"
    [ -f ~/.bashrc ] && source ~/.bashrc
    [ -f ~/.profile ] && source ~/.profile
    [ -f ~/.tmux.conf ] && command_exists tmux && tmux source-file ~/.tmux.conf 2>/dev/null || true
}