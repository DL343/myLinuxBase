#!/bin/bash


read -p "¿Instalar PipeWire? (y/n) " isPipeWire
export isPipeWire

read -p "¿Instalar Qemu/KVM? (y/n) " isQemuKVM
export isQemuKVM

read -p "¿Instalar Polkit/PolicyKit? (y/n) " isPolkit
export isPolkit

read -p "¿Instalar soporte para Bluetooth? (y/n) " isBluetooth
export isBluetooth

read -p "¿Instalar flatpak? (y/n) " isFlatpak
export isFlatpak 


## ¿Connman o NetworkManager?






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

