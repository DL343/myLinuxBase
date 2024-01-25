#!/bin/bash

echo '########## APPS BASICAS ##########'
## Actualizacion repositorios
sudo apt update 

## BASE
sudo apt install nala -y
sudo nala upgrade -y

sudo nala install xorg -y

sudo nala install htop neofetch gparted tlp git ufw xdg-user-dirs icewm -y
sudo nala install lm-sensors nano inxi bash-completion -y

sudo nala install p7zip-full arandr gvfs network-manager-gnome -y
sudo nala install brightnessctl acpi lightdm lightdm-gtk-greeter -y

sudo nala install rofi redshift gnome-screenshot -y
sudo nala install thunar lxappearance sakura  -y


## OPCIONALES
sudo nala install geany bleachbit -y
## sudo nala install gthumb  xarchiver vlc firefox-esr -y



echo '########## CONFIGURACION DE LIBINPUT ##########'
sudo sed -i '36a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf 


#echo '########## CONFIGURACION DE POLKIT ##########'
#sudo nala install policykit-1-gnome
#echo "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &" >> $HOME/.icewm/startup  

echo '########## GENERACION DE CARPETAS DE USUARIO BASICAS ##########'
xdg-user-dirs-update 

#echo '########## CONFIGURACION DE GRUB ##########'
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
sudo update-grub



