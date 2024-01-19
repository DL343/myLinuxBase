#!/bin/bash



echo "################### SISTEMA ###################" 
## Instalcion apps minimas y opcionales
./system/apps.sh

## Configuracion de libinput
sudo sed -i '36a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf 

echo "################### LIGHTDM ###################" 
## Activar el DM
sudo systemctl enable lightdm.service

echo "################### UFW ###################" 
## Activacion ufw
sudo ufw enable 

echo "################### TLP ###################" 
## Activacion
sudo tlp start 

## Conf en modo bateria
sudo tlp bat

echo "################### ICEWM ###################" 
## Configracion inicial
./iceWM/initConf.sh

## Inicio Automatico
./iceWM/inicioAutomatico.sh

## Atajos
./iceWM/atajos.sh

## Walpaper
./iceWM/wallpaper.sh

## Establecer tema
./iceWM/setTheme.sh

echo "################### THUNAR ###################" 
## Configurar terminal por defecto
./thunar/setDefaultTerminal.sh

echo "################### PIPEWIRE ###################" 
./audio/pipewire.sh

echo "################### FLATPAK ###################" 
## Instalacion base
./flatpak/instFlatpak.sh

## Instalacion apps
#./flatpak/appsFlatpak.sh

echo "################### DEBLOAT DEBIAN ###################" 
./system/debloatDebian.sh


