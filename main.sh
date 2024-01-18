#!/bin/bash

############ SISTEMA ############ 
## Actualizacion
sudo apt update && sudo apt upgrade

## Instalcion apps minimas y opcionales
./system/apps.sh

## Configuracion de libinput
sudo sed -i '36a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf 

## Debloat Debian

############ LIGHTDM ############ 
## Activar el DM
sudo systemctl enable lightdm.service

############ UFW ############ 
## Activacion ufw
sudo ufw enable 

############ ICEWM ############ 
## Configracion inicial
./iceWM/initConf.sh

## Inicio Automatico
./iceWM/inicioAutomatico.sh

## Atajos
./iceWM/atajos.sh

## Walpaper
./iceWM/wallpaper.sh

############ THUNAR ############ 
## Configurar terminal por defecto
./thunar/setDefaultTerminal.sh

############ PIPEWIRE ############
./audio/pipewire.sh

############ FLATPAK ############
## Instalacion base
./flatpak/instFlatpak.sh

## Instalacion apps
## ./flatpak/appsFlatpak.sh

