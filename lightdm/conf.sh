#!/bin/bash

echo '###### ASEGURAR INSTALACION ######'
sudo nala install lightdm

sudo nala install lightdm-gtk-greeter

echo '###### HABILITAR EL DM ######'
sudo systemctl enable lightdm.service

echo '###### PERSONALIZACION ######' 

## Dar de alta greeter
sudo sed -i '65a greeter-session=lightdm-gtk-greeter-settings' /etc/lightdm/lightdm.conf  

## Establecer wallpaper
sudo cp ./lightdm/wallpaper/lightdm.jpg /usr/share/pixmaps/lightdm.jpg


## Configuracion


sudo echo '[greeter]
background = /usr/share/pixmaps/lightdm.jpg
theme-name = Adwaita-dark
icon-theme-name = Adwaita


' > /etc/lightdm/lightdm-gtk-greeter.conf



