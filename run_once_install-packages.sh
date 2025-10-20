#!/bin/bash
#echo "##############################################"
#echo "update and upgrade"
#echo "##############################################"
if sudo grep -Fxq "$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers
then
    echo "==================================================================="
    echo "Already grant access to user, no password required for sudo command"
    echo "==================================================================="
else
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
fi

sudo apt             -y update           
sudo apt             -y upgrade          
sudo apt-get         -y update
sudo apt-get         -y upgrade          

# install packages
echo "##############################################"
echo "command line tools(alacritty terminal)"
echo "##############################################"
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt     install -y alacritty 
sudo apt     install -y ranger           
sudo apt     install -y w3m           
sudo apt     install -y w3m-img #ranger image preview           
sudo apt     install -y fzf
sudo apt     install -y fd-find
sudo apt     install -y git              
sudo apt     install -y whois              
sudo apt     install -y openssh-client #generate ssh key             
sudo apt     install -y tmux             
sudo apt     install -y osdclock
sudo apt     install -y unrar
sudo apt     install -y ffmpeg
sudo apt     install -y mediainfo
sudo apt     install -y kazam
sudo apt     install -y ncdu
sudo apt     install -y vnstat
sudo apt     install -y neofetch
sudo apt     install -y curl
sudo apt     install -y btop
sudo apt     install -y fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk3 #input method for 22.04 plain pinyin
sudo snap    install -y aws-cli --classic

# development environment 
echo "##############################################"
echo "node/npm/n(version manager)"
echo "##############################################"
sudo apt     install -y nodejs npm
sudo npm     install -g n
sudo n       lts           # install long term support node version

echo "##############################################"
echo "git"
echo "##############################################"
# install git credentail manager
LATEST_URL=$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | grep "browser_download_url.*gcm-linux_amd64.*\.deb" | cut -d '"' -f 4) && \
FILENAME=$(basename "$LATEST_URL") && \
curl -LO "$LATEST_URL" && \
sudo dpkg -i "$FILENAME" && \
rm "$FILENAME"

# Verify config was applied
git config --global --get-regexp credential

# Check if 'gh' command exists
if ! command -v gh >/dev/null 2>&1; then
    echo "GitHub CLI not found. Installing..."

    # Ensure wget is installed, then install GitHub CLI
    (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y

    echo "GitHub CLI installed successfully."
else
    echo "GitHub CLI is already installed."
fi


echo "##############################################"
echo "aws"
echo "##############################################"
sudo snap    install -y aws-cli --classic # aws-cli
sudo npm     install -g aws-cdk           # cdk

echo "##############################################"
echo "docker management tool"
echo "##############################################"

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    echo "Docker is already installed: $DOCKER_VERSION"
    echo "Skipping Docker installation..."
else
    echo "Docker not found. Installing Docker..."
    
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt-get update
    
    # Install Docker
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    echo "Docker installed successfully!"
fi

# Check if user is already in docker group
if groups $USER | grep -q '\bdocker\b'; then
    echo "User $USER is already in the docker group."
else
    echo "Adding user $USER to docker group..."
    sudo usermod -aG docker $USER
    echo "User added to docker group. You'll need to log out and back in for this to take effect."
    echo "Or run: newgrp docker"
fi

# Install/Update lazydocker
echo "Installing/Updating lazydocker..."
if command -v lazydocker &> /dev/null; then
    echo "lazydocker is already installed. Updating..."
else
    echo "Installing lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

# backend
echo "##############################################"
echo "database"
echo "##############################################"
docker pull postgres:lastest

# editor 
echo "##############################################"
echo "nano/vim"
echo "##############################################"
sudo apt     remove   -y nano                 
sudo apt     remove   -y vim-gtk3                 
sudo apt     install  -y vim                 
sudo apt     install  -y neovim
sudo apt     install  -y ripgrep # a neovim plugin or dependency
sudo npm     install  -g prettier # a neovim plugin or dependency
sudo npm     install  -g typescript # a neovim plugin or dependency
sudo npm     install  -g pyright # a neovim plugin or dependency for python

# media
echo "##############################################"
echo "mpv"
echo "##############################################"
sudo apt     install -y mpv              

echo "##############################################"
echo "chrome"
echo "##############################################"
if command -v google-chrome >/dev/null 2>&1; then
    echo "✅ Google Chrome is already installed. Skipping installation."
else
    echo "⬇️  Downloading and installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
    rm   ./google-chrome-stable_current_amd64.deb
fi

echo "##############################################"
echo "wechat"
echo "##############################################"
if command -v wechat >/dev/null 2>&1; then
    echo "✅ WeChat is already installed. Skipping installation."
else
    echo "⬇️  Downloading and installing WeChat for Linux..."
    wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb
    sudo apt install ./WeChatLinux_x86_64.deb
    rm   ./WeChatLinux_x86_64.deb
fi

# pdf
echo "##############################################"
echo "zathura"
echo "##############################################"
sudo apt     install -y zathura          
echo "##############################################"
echo "flameshot screenshot"
echo "##############################################"
sudo apt     install -y flameshot          

echo "##############################################"
echo "gnome"
echo "##############################################"
gsettings set org.gnome.desktop.interface enable-animations false 
sudo      apt -y  remove update-notifier update-notifier-common
sudo      apt -y  remove gnome-software 
sudo      snap remove snap-store -y

# system tool
echo "##############################################"
echo "python"
echo "##############################################"
sudo apt     install -y python          # install python2      
sudo apt     install -y python3         # install python3 
sudo apt     install -y python-pip      # pip/pip2      
sudo apt     install -y python3-pip     # pip3  
sudo pip3    install tldr   

echo "##############################################"
echo "yt-dlp"
echo "##############################################"
python3 -m pip install -U yt-dlp

echo "##############################################"
echo "clean updates"
echo "##############################################"
sudo fc-cache -fv  # load all fonts for neovim editor
sudo apt     -y clean
sudo apt     -y autoremove
sudo apt     -y autoclean

echo "##############################################"
echo "load source files"
echo "##############################################"
source ~/.bashrc;
source ~/.profile;
tmux   source-file ~/.tmux.conf

echo "##############################################"
echo "done"
echo "##############################################"
