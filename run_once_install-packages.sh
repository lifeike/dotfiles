#!/bin/bash

# Source utility functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/install-utils.sh"

# Grant sudo access without password
setup_passwordless_sudo

# System update
system_update

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
install_apt ffmpeg
install_apt mediainfo
install_apt kazam
install_apt ncdu
install_apt vnstat
install_apt curl
install_apt btop
install_apt fcitx5
install_apt fcitx5-chinese-addons
install_apt fcitx5-frontend-gtk3
install_apt awesome
install_apt awesome-extra
install_apt suckless-tools  # contains slock to lock screen
install_apt brightnessctl # lock screen
install_apt ncal
install_apt tealdeer
install_apt pipx
install_apt cargo
# email neomut
install_apt neomutt
install_apt isync
install_apt pass
# remove unused debian utilities
sudo apt purge -y installation-report

# Node.js and npm
print_header "Node.js/npm/n"
install_apt nodejs
install_apt npm
# n
if command_exists n; then
    echo -e "${GREEN}✓${NC} n (node version manager) is already installed"
else
    echo -e "${YELLOW}→${NC} Installing n globally via npm..."
    sudo npm install -g n
    sudo n lts
fi

# Gemini CLI
print_header "Gemini CLI"
if command_exists gemini; then
    echo -e "${GREEN}✓${NC} gemini-cli is already installed"
else
    echo -e "${YELLOW}→${NC} Installing gemini-cli..."
    sudo npm install -g @google/gemini-cli
fi

# Git credential manager
print_header "Git Configuration"
if command_exists git-credential-manager; then
    echo -e "${GREEN}✓${NC} Git Credential Manager is already installed"
else
    echo -e "${YELLOW}→${NC} Installing Git Credential Manager..."
    LATEST_URL=$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | grep "browser_download_url.*gcm-linux_amd64.*\.deb" | cut -d '"' -f 4)
    install_deb_from_url "$LATEST_URL" "Git Credential Manager"
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

# Docker Installation for Debian
print_header "Docker"
if command_exists docker; then
    DOCKER_VERSION=$(docker --version)
    echo -e "${GREEN}✓${NC} Docker is already installed: $DOCKER_VERSION"
else
    echo -e "${YELLOW}→${NC} Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    echo -e "${GREEN}✓${NC} Docker installed successfully"
fi

# Add user to docker group
add_user_to_group docker

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
# install_apt vim
install_snap nvim
install_apt ripgrep
install_npm_global prettier
install_npm_global typescript

# Media
print_header "Media Player"
install_apt mpv

# Chrome
print_header "Google Chrome"
if command_exists google-chrome; then
    echo -e "${GREEN}✓${NC} Google Chrome is already installed"
else
    install_deb_from_url "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" "Google Chrome"
fi

# WeChat
print_header "WeChat"
if command_exists wechat; then
    echo -e "${GREEN}✓${NC} WeChat is already installed"
else
    install_deb_from_url "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb" "WeChat"
fi

# PDF viewer
print_header "PDF Viewer"
install_apt zathura

# Screenshot tool
print_header "Screenshot Tool"
install_apt flameshot

# Python
print_header "Python"
install_apt python3
install_apt python3-pip
install_apt pipx
install_pip uv                     
install_pip vimiv                     # installs vimiv via pip3 --user
install_pip ty                     
install_pip yt-dlp "python3 -m pip install -U yt-dlp"   # custom install command

# Cleanup
cleanup_system

# Load configuration files
load_configs

print_header "Installation Complete!"
echo -e "${GREEN}✓${NC} All installations finished successfully"
