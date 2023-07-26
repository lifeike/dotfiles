#!/bin/bash
#echo "##############################################"
#echo "update and upgrade"
#echo "##############################################"
#sudo apt             -y update           
#sudo apt             -y upgrade          
#sudo apt-get         -y update          
#sudo apt-get         -y upgrade          
#echo "##############################################"
#echo "done"
#echo "##############################################"
#
## install packages
echo "##############################################"
echo "ranger/git/tmux"
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

echo "##############################################"
echo "done"
echo "##############################################"
#
## editor 
#echo "##############################################"
#echo "nano/vim"
#echo "##############################################"
#sudo apt     remove  -y nano                 
#sudo apt-get install -y vim-gtk          
## sudo snap install --classic code
#echo "##############################################"
#echo "done"
#echo "##############################################"
#
## media
#echo "##############################################"
#echo "mpv"
#echo "##############################################"
#sudo apt     install -y mpv              
#echo "##############################################"
#echo "done"
#echo "##############################################"
#
#echo "##############################################"
#echo "chrome"
#echo "##############################################"
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome-stable_current_amd64.deb
#rm google-chrome-stable_current_amd64.deb
#echo "##############################################"
#echo "done"
#echo "##############################################"
#
## pdf
#echo "##############################################"
#echo "zathura"
#echo "##############################################"
#sudo apt     install -y zathura          
#echo "##############################################"
#echo "done"
#echo "##############################################"
#
## boxes
#echo "##############################################"
#echo "gnome-boxes"
#echo "##############################################"
#sudo apt-get install -y gnome-boxes      
#echo "##############################################"
#echo "done"
#echo "##############################################"

# # system tool
#echo "##############################################"
#echo "python/glances"
#echo "##############################################"
#sudo apt     install -y python3-pip      
#sudo pip     install --upgrade glances   
#echo "##############################################"
#echo "done"
#echo "##############################################"

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
echo "done"
echo "##############################################"

echo "##############################################"
echo "load source files"
echo "##############################################"
cd $HOME;
xrdb ~/.Xresources;
source ~/.bashrc;
echo "##############################################"
echo "done"
echo "##############################################"
