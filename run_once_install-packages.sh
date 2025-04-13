#!/bin/bash
#echo "##############################################"
#echo "update and upgrade"
#echo "##############################################"
if sudo grep -Fxq "$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers
then
    echo "Already Grant Access To User, No Password Need For Sudo Command"
else
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
fi
sudo apt             -y update           
sudo apt             -y upgrade          

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
sudo apt     install -y gh #github cli             
sudo apt     install -y tmux             
sudo apt     install -y osdclock
sudo apt     install -y unrar
sudo apt     install -y ffmpeg
sudo apt     install -y mediainfo
sudo apt     install -y kazam
sudo apt     install -y ncdu
sudo apt     install -y vnstat
sudo apt     install -y neofetch
sudo apt     install -y fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk3 #input method for 22.04 plain pinyin

# editor 
echo "##############################################"
echo "nano/vim"
echo "##############################################"
sudo apt     remove  -y nano                 
sudo apt     install  -y vim
sudo apt     install  -y neovim
sudo apt     install  -y ripgrep # a neovim plugin or dependency

# development environment 
echo "##############################################"
echo "node/npm/n(version manager)"
echo "##############################################"
sudo apt     install -y nodejs npm
sudo npm     install -g n
sudo n       lts           # install long term support node version
sudo npm     install -g prettier # a neovim plugin or dependency

# media
echo "##############################################"
echo "mpv"
echo "##############################################"
sudo apt     install -y mpv              

echo "##############################################"
echo "yt-dlp"
echo "##############################################"
sudo apt     install -y python3-pip              
python3 -m pip install -U yt-dlp

echo "##############################################"
echo "git"
echo "##############################################"
git config --global credential.helper store # save git credentials on input on next pull or push

echo "##############################################"
echo "chrome"
echo "##############################################"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm   ./google-chrome-stable_current_amd64.deb

echo "##############################################"
echo "wechat"
echo "##############################################"
wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb
sudo apt install ./WeChatLinux_x86_64.deb
rm   ./WeChatLinux_x86_64.deb

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

# games
echo "##############################################"
echo "hero3"
echo "##############################################"
sudo apt     install -y vcmi      

 # system tool
echo "##############################################"
echo "python/glances"
echo "##############################################"
sudo apt     install -y python-pip  # pip/pip2      
sudo apt     install -y python3-pip # pip3  
sudo pip     install --upgrade glances   
sudo pip3    install tldr   

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

echo "##############################################"
echo "done"
echo "##############################################"
