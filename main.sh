#!/bin/bash


read -p "¿Instalar PipeWire? (y/n) " isPipeWire
export isPipeWire

read -p "¿Instalar flatpak? (y/n) " isFlatpak
export isFlatpak 

read -p "¿Instalar Qemu/KVM? (y/n) " isQemuKVM
export isQemuKVM




echo "############################ SISTEMA #############################" 
./system/system.sh

echo "############################ LIGHTDM #############################" 
./lightdm/conf.sh

echo "############################# ICEWM ##############################" 
./iceWM/icewm.sh

echo "############################ FLATPAK #############################" 
./flatpak/flatpak.sh

echo "############################ DEBLOAT?? ###########################"
./system/debloat.sh

echo "############################ MY APPS ###########################"
./system/myApps.sh
