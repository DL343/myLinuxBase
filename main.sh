#!/bin/bash

echo "################### SISTEMA ###################" 
./system/system.sh

echo "################### LIGHTDM ###################" 
./lightdm/conf.sh

echo "################### UFW ###################" 
## Activacion ufw
sudo ufw enable 

echo "################### TLP ###################" 
## Activacion
sudo tlp start 

## Conf en modo bateria
sudo tlp bat

echo "################### ICEWM ###################" 
./iceWM/icewm.sh

echo "################### THUNAR ###################" 
./thunar/setDefaultTerminal.sh

echo "################### PIPEWIRE ###################" 
./audio/pipewire.sh

echo "################### FLATPAK ###################" 
## Instalacion base
./flatpak/flatpak.sh

echo "################### DEBLOAT?? ###################" 
./system/debloat.sh



