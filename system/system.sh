#!/bin/bash

echo '########## APPS BASICAS ##########'
## Actualizacion repositorios
sudo apt update 

## BASE
sudo apt install nala -y
sudo nala upgrade -y

sudo nala install xorg -y

sudo nala install htop neofetch gparted tlp git ufw xdg-user-dirs -y
sudo nala install lm-sensors nano inxi bash-completion -y

sudo nala install p7zip-full arandr gvfs network-manager-gnome -y
sudo nala install brightnessctl acpi lightdm lightdm-gtk-greeter -y

sudo nala install rofi redshift gnome-screenshot thunar  -y
sudo nala install lxappearance  qalculate-gtk arandr  -y
sudo nala install sakura icewm parcellite -y


## OPCIONALES
sudo nala install geany bleachbit android-file-transfer mirage -y
## sudo nala install gthumb  xarchiver vlc firefox-esr -y



echo '########## CONFIGURACION DE LIBINPUT ##########'
sudo sed -i '36a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf 


#echo '########## CONFIGURACION DE POLKIT ##########'
#sudo nala install policykit-1-gnome
#echo "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &" >> $HOME/.icewm/startup  

echo '########## GENERACION DE CARPETAS DE USUARIO BASICAS ##########'
xdg-user-dirs-update 

echo '########## CONFIGURACION DE GRUB ##########'
### Contador a 1s
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

### Guardar la ultima particion seleccionada
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub

sudo update-grub

echo '########## APARIENCIA ##########'
mkdir -p $HOME/.config/gtk-3.0/

echo "[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=URW Gothic 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
" > $HOME/.config/gtk-3.0/settings.ini



