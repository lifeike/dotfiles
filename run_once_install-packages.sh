#!/bin/bash

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
        sudo snap install $flags "$package"
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

# Grant sudo access without password
if sudo grep -Fxq "$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers; then
    echo -e "${GREEN}✓${NC} User already has passwordless sudo access"
else
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
fi

# System update
print_header "System Update"
sudo apt update -y
sudo apt upgrade -y
sudo apt-get update -y
sudo apt-get upgrade -y

# Command line tools
print_header "Command Line Tools"
install_apt kitty
install_apt ranger
install_apt w3m
install_apt w3m-img
install_apt fzf
install_apt fd-find
install_apt git
install_apt whois
install_apt openssh-client
install_apt tmux
install_apt unrar
install_apt ffmpeg
install_apt mediainfo
install_apt kazam
install_apt ncdu
install_apt vnstat
install_apt neofetch
install_apt curl
install_apt btop
install_apt fcitx5
install_apt fcitx5-chinese-addons
install_apt fcitx5-frontend-gtk3
install_apt awesome
install_apt awesome-extra
install_apt slock # lock screen

# Node.js and npm
print_header "Node.js/npm/n"
install_apt nodejs
install_apt npm

if command_exists n; then
    echo -e "${GREEN}✓${NC} n (node version manager) is already installed"
else
    echo -e "${YELLOW}→${NC} Installing n globally via npm..."
    sudo npm install -g n
    sudo n lts
fi

# Git credential manager
print_header "Git Configuration"
if command_exists git-credential-manager; then
    echo -e "${GREEN}✓${NC} Git Credential Manager is already installed"
else
    echo -e "${YELLOW}→${NC} Installing Git Credential Manager..."
    LATEST_URL=$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | grep "browser_download_url.*gcm-linux_amd64.*\.deb" | cut -d '"' -f 4)
    FILENAME=$(basename "$LATEST_URL")
    curl -LO "$LATEST_URL"
    sudo dpkg -i "$FILENAME"
    rm "$FILENAME"
fi

git config --global --get-regexp credential

# GitHub CLI
if command_exists gh; then
    echo -e "${GREEN}✓${NC} GitHub CLI is already installed"
else
    echo -e "${YELLOW}→${NC} Installing GitHub CLI..."
    (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
fi

# AWS tools
print_header "AWS Tools"
install_snap aws-cli "--classic"
install_npm_global aws-cdk

# Docker
print_header "Docker"
if command_exists docker; then
    DOCKER_VERSION=$(docker --version)
    echo -e "${GREEN}✓${NC} Docker is already installed: $DOCKER_VERSION"
else
    echo -e "${YELLOW}→${NC} Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# Add user to docker group
if groups $USER | grep -q '\bdocker\b'; then
    echo -e "${GREEN}✓${NC} User $USER is already in the docker group"
else
    echo -e "${YELLOW}→${NC} Adding user $USER to docker group..."
    sudo usermod -aG docker $USER
    echo "User added to docker group. Log out and back in, or run: newgrp docker"
fi

# Lazydocker
if command_exists lazydocker; then
    echo -e "${GREEN}✓${NC} lazydocker is already installed"
else
    echo -e "${YELLOW}→${NC} Installing lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

# Database
print_header "Database"
if docker images | grep -q "postgres"; then
    echo -e "${GREEN}✓${NC} PostgreSQL Docker image already exists"
else
    echo -e "${YELLOW}→${NC} Pulling PostgreSQL Docker image..."
    docker pull postgres:latest
fi

# Editors
print_header "Editors (nano/vim/neovim)"
sudo apt remove -y nano 2>/dev/null || true
sudo apt remove -y vim-gtk3 2>/dev/null || true
install_apt vim
install_apt neovim
install_apt ripgrep
install_npm_global prettier
install_npm_global typescript
install_npm_global pyright

# Media
print_header "Media Player"
install_apt mpv

# Chrome
print_header "Google Chrome"
if command_exists google-chrome; then
    echo -e "${GREEN}✓${NC} Google Chrome is already installed"
else
    echo -e "${YELLOW}→${NC} Installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm ./google-chrome-stable_current_amd64.deb
fi

# WeChat
print_header "WeChat"
if command_exists wechat; then
    echo -e "${GREEN}✓${NC} WeChat is already installed"
else
    echo -e "${YELLOW}→${NC} Installing WeChat..."
    wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb
    sudo apt install -y ./WeChatLinux_x86_64.deb
    rm ./WeChatLinux_x86_64.deb
fi

# PDF viewer
print_header "PDF Viewer"
install_apt zathura

# Screenshot tool
print_header "Screenshot Tool"
install_apt flameshot

# GNOME settings
print_header "GNOME Configuration"
gsettings set org.gnome.desktop.interface enable-animations false 2>/dev/null || true
sudo apt remove -y update-notifier update-notifier-common 2>/dev/null || true
sudo apt remove -y gnome-software 2>/dev/null || true
sudo snap remove snap-store 2>/dev/null || true

# Python
print_header "Python"
install_apt python3
install_apt python3-pip

if pip3 list | grep -q "^tldr "; then
    echo -e "${GREEN}✓${NC} tldr is already installed"
else
    echo -e "${YELLOW}→${NC} Installing tldr via pip3..."
    sudo pip3 install tldr
fi

# yt-dlp
print_header "yt-dlp"
if command_exists yt-dlp; then
    echo -e "${GREEN}✓${NC} yt-dlp is already installed"
else
    echo -e "${YELLOW}→${NC} Installing yt-dlp..."
    python3 -m pip install -U yt-dlp
fi

# Cleanup
print_header "Cleanup"
sudo fc-cache -fv
sudo apt clean -y
sudo apt autoremove -y
sudo apt autoclean -y

# Load configuration files
print_header "Loading Configuration Files"
[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.profile ] && source ~/.profile
[ -f ~/.tmux.conf ] && command_exists tmux && tmux source-file ~/.tmux.conf 2>/dev/null || true

print_header "Installation Complete!"
echo -e "${GREEN}✓${NC} All installations finished successfully"
