#!/bin/bash
sudo apt             -y update
sudo apt             -y upgrade

# install packages
sudo apt     install -y ranger
sudo apt     install -y git
sudo apt     install -y tmux

# editor 
sudo apt     remove  -y nano
sudo apt-get install -y vim-gtk
# sudo snap install --classic code

# media
sudo apt     install -y mpv

# pdf
sudo apt     install -y zathura

# boxes
sudo apt-get install -y gnome-boxes

# system tool
sudo apt     install -y python3-pip
sudo pip     install --upgrade glances

# load source files
cd $HOME;
xrdb ~/.Xresources;
source ~/.bashrc
