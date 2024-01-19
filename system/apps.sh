#!/bin/bash


## Actualizacion
sudo apt update && sudo apt upgrade -y

## BASE
sudo apt install nala -y
sudo nala upgrade -y

sudo nala install xorg -y

sudo nala install htop neofetch gparted tlp git ufw -y
sudo nala install lm-sensors nano inxi bash-completion -y

sudo nala install p7zip-full arandr gvfs network-manager-gnome -y
sudo nala install brightnessctl acpi lightdm -y

sudo nala install rofi redshift gnome-screenshot -y
sudo nala install thunar lxappearance sakura


## OPCIONALES
## sudo nala install gthumb bleachbit geany xarchiver vlc firefox-esr -y
