#!/bin/bash

function askPowerSaveTLP(){
	if [ "$isTlp" == "y" ] || [ "$isTlp" == "Y" ] ||  [ "$isTlp" == "" ]; then
		read -p "└───────¿Activar el modo ahorro de energia? [y/n] " isPowerSave
		export isPowerSave
	fi	
}





read -p "¿Ejecutar script 'Debloat'? [y/n] " isDebloat
export isDebloat

read -p "¿Instalacion de apps minimas? [y/n] " isMinimal
export isMinimal

read -p "¿Instalar soporte para Bluetooth? [y/n] " isBluetooth
export isBluetooth

read -p "¿Instalar PipeWire(Servidor de audio y video)? 
(Se removera PulseAudio(otro servidor de audio[legacy]) si es que existe) 
[y/n] " isPipeWire
export isPipeWire

read -p "¿Instalar TLP(Ahorro de bateria)? [y/n] " isTlp
export isTlp
askPowerSaveTLP

read -p "¿Instalar Qemu/KVM? [y/n] " isQemuKVM
export isQemuKVM







echo "############################ DEBLOAT #############################"
./system/debloat/debloat.sh 



echo "############################ SISTEMA #############################" 
cd ./system/
./system.sh
cd ..


cd ./añadidos/apariencia/
./setAppearance.sh
cd ..
cd ..


./añadidos/Toggles/setToogles.sh




echo "############################# ICEWM ##############################" 
cd ./WM/iceWM/

./icewm.sh

cd ..
cd ..






echo "############################ OTRAS APPS #############################"
./system/myApps.sh 


