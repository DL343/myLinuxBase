#!/bin/bash

## BASE
sudo apt install nala
sudo nala upgrade

sudo nala install xorg -y

sudo nala install htop neofetch gparted tlp git ufw lm-sensors nano inxi bash-completion -y

sudo nala install p7zip-full arandr gvfs network-manager-gnome brightnessctl acpi lightdm -y

sudo nala install rofi redshift gnome-screenshot thunar lxappearance sakura -y


## OPCIONALES
## sudo nala install gthumb bleachbit geany xarchiver vlc firefox-esr -y
