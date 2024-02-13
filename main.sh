#!/bin/bash

function askPowerSaveTLP(){
	if [ "$isTlp" == "y" ] || [ "$isTlp" == "Y" ] ||  [ "$isTlp" == "" ]; then
		read -p "└───────¿Activar el modo ahorro de energia? [y/n] " isPowerSave
		export isPowerSave
	fi	
}

function askInit() {
	if [ $(ps -p 1 -o comm=) ==  "systemd" ]; then
		echo "systemd"
	else
		echo "init"
	fi
}

export isInit=$(askInit)



read -p "¿Instalar PipeWire? (Se removera PulseAudio si es que existe) [y/n] " isPipeWire
export isPipeWire

read -p "¿Instalar Qemu/KVM? [y/n] " isQemuKVM
export isQemuKVM

read -p "¿Instalar Polkit/PolicyKit de Gnome? [y/n] " isPolkit
export isPolkit

read -p "¿Instalar soporte para Bluetooth? [y/n] " isBluetooth
export isBluetooth

read -p "¿Instalar flatpak? [y/n] " isFlatpak
export isFlatpak 

read -p "¿Instalar TLP? [y/n] " isTlp
export isTlp
askPowerSaveTLP




echo "############################ SISTEMA #############################" 
./system/system.sh


echo "############################ TLP #############################" 
./tlp/tlp.sh


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


