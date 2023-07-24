#!/bin/bash
echo "##############################################"
echo "update and upgrade"
echo "##############################################"
sudo apt             -y update           &> /dev/null
sudo apt             -y upgrade          &> /dev/null
echo "##############################################"
echo "done"
echo "##############################################"

# install packages
echo "##############################################"
echo "ranger/git/tmux"
echo "##############################################"
sudo apt     install -y ranger           &> /dev/null
sudo apt     install -y git              &> /dev/null
sudo apt     install -y tmux             &> /dev/null
echo "##############################################"
echo "done"
echo "##############################################"

# editor 
echo "##############################################"
echo "nano/vim"
echo "##############################################"
sudo apt     remove  -y nano             &> /dev/null    
sudo apt-get install -y vim-gtk          &> /dev/null
# sudo snap install --classic code
echo "##############################################"
echo "done"
echo "##############################################"

# media
echo "##############################################"
echo "mpv"
echo "##############################################"
sudo apt     install -y mpv              &> /dev/null
echo "##############################################"
echo "done"
echo "##############################################"


# pdf
echo "##############################################"
echo "zathura"
echo "##############################################"
sudo apt     install -y zathura          &> /dev/null
echo "##############################################"
echo "done"
echo "##############################################"

# boxes
echo "##############################################"
echo "gnome-boxes"
echo "##############################################"
sudo apt-get install -y gnome-boxes      &> /dev/null
echo "##############################################"
echo "done"
echo "##############################################"

# system tool
echo "##############################################"
echo "python/glances"
echo "##############################################"
sudo apt     install -y python3-pip      &> /dev/null
sudo pip     install --upgrade glances   &> /dev/null
echo "##############################################"
echo "done"
echo "##############################################"

# load source files
echo "##############################################"
cd $HOME;
xrdb ~/.Xresources;
source ~/.bashrc
