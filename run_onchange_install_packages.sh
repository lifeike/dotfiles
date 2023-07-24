#!/bin/bash
sudo apt             -y update           &> /dev/null
sudo apt             -y upgrade          &> /dev/null

# install packages
sudo apt     install -y ranger           &> /dev/null
sudo apt     install -y git              &> /dev/null
sudo apt     install -y tmux             &> /dev/null

# editor 
sudo apt     remove  -y nano             &> /dev/null    
sudo apt-get install -y vim-gtk          &> /dev/null
# sudo snap install --classic code

# media
sudo apt     install -y mpv              &> /dev/null

# pdf
sudo apt     install -y zathura          &> /dev/null

# boxes
sudo apt-get install -y gnome-boxes      &> /dev/null

# system tool
sudo apt     install -y python3-pip      &> /dev/null
sudo pip     install --upgrade glances   &> /dev/null

# load source files
cd $HOME;
xrdb ~/.Xresources;
source ~/.bashrc
