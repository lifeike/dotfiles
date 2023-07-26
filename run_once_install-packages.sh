#!/bin/bash
#echo "##############################################"
#echo "update and upgrade"
#echo "##############################################"
#sudo apt             -y update           
#sudo apt             -y upgrade          
#sudo apt-get         -y update          
#sudo apt-get         -y upgrade          
#
## install packages
echo "##############################################"
echo "command line tools"
echo "##############################################"
sudo apt     install -y ranger           
sudo apt     install -y fzf
sudo apt     install -y fd-find
sudo apt     install -y git              
sudo apt     install -y rxvt-unicode
sudo apt     install -y wmctrl
sudo apt     install -y tmux             
sudo apt     install -y osdclock
sudo apt     install -y unrar
sudo apt     install -y ffmpeg
sudo apt     install -y mediainfo
sudo apt     install -y kazam
#
## editor 
#echo "##############################################"
#echo "nano/vim"
#echo "##############################################"
#sudo apt     remove  -y nano                 
#sudo apt-get install -y vim-gtk          
#sudo snap    install --classic code
#
## media
#echo "##############################################"
#echo "mpv"
#echo "##############################################"
#sudo apt     install -y mpv              
#echo "##############################################"
#echo "yt-dlp"
#echo "##############################################"
#sudo apt     install -y python3-pip              
#python3 -m pip install -U yt-dlp
#
#echo "##############################################"
#echo "chrome"
#echo "##############################################"
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome-stable_current_amd64.deb
#rm google-chrome-stable_current_amd64.deb
#
## pdf
#echo "##############################################"
#echo "zathura"
#echo "##############################################"
#sudo apt     install -y zathura          
#echo "##############################################"
#echo "flameshot screenshot"
#echo "##############################################"
#sudo apt     install -y flameshot          
#
## boxes
#echo "##############################################"
#echo "gnome-boxes"
#echo "##############################################"
#sudo apt-get install -y gnome-boxes      

# # system tool
#echo "##############################################"
#echo "python/glances"
#echo "##############################################"
#sudo apt     install -y python3-pip      
#sudo pip     install --upgrade glances   

echo "##############################################"
echo "clean updates"
echo "##############################################"
sudo apt     -y clean
sudo apt-get -y clean
sudo apt     -y autoremove
sudo apt-get -y autoremove
sudo apt     -y autoclean
sudo apt-get -y autoclean

echo "##############################################"
echo "load source files"
echo "##############################################"
cd $HOME;
xrdb ~/.Xresources;
source ~/.bashrc;
echo "##############################################"
echo "done"
echo "##############################################"
