#!/bin/bash

echo '###### ASEGURAR INSTALACION ######'
sudo nala install lightdm
sudo nala install lightdm-gtk-greeter

echo '###### HABILITAR EL DM ######'
sudo systemctl enable lightdm.service

echo '###### PERSONALIZACION ######' 

## Dar de alta greeter
sudo sed -i '/# greeter-session=lightdm-gtk-greeter-settings/cgreeter-session=lightdm-gtk-greeter-settings' /etc/lightdm/lightdm.conf 

## Copiado de wallpaper
sudo cp ./lightdm/wallpaper/* /usr/share/pixmaps/lightdm.jpg


## Configuracion del wallpaper
echo '[greeter]
background = /usr/share/pixmaps/lightdm.jpg
theme-name = Adwaita-dark
icon-theme-name = Adwaita

' | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf



## Desactivar la ocultacion de los usuarios disponibles
sudo sed -i 's/greeter-hide-users=true/greeter-hide-users=false/g' /usr/share/lightdm/lightdm.conf.d/01_debian.conf 

