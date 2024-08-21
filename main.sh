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

read -p "¿Instalar PipeWire? 
(Se removera PulseAudio si es que existe) 
[y/n] " isPipeWire
export isPipeWire

read -p "¿Instalar TLP(Ahorro de bateria)? [y/n] " isTlp
export isTlp
askPowerSaveTLP

read -p "¿Instalar Qemu/KVM? [y/n] " isQemuKVM
export isQemuKVM


while true 
do

	read -p "
	###############################
	SELECCIONA UN WM/DE:
	1) IceWM
	2) XFCE
	3) i3
	4) Ninguno
	###############################
	
	" seleccion



	case $seleccion in
		1)
			echo "## > Se selecciono IceWM"
			
			## Ingresando a iceWM.sh
			cd ./WM/iceWM/
			./iceWM.sh

			## Regresando a la posicion de main
			cd ..
			cd ..

			break
			;;
		2)
			echo "## > Se selecciono XFCE"
			
			## Ingresando a iceWM.sh
			cd ./WM/XFCE/
			./XFCE.sh

			## Regresando a la posicion de main
			cd ..
			cd ..

			
			break
			;;
		3)
			echo "## > Se selecciono i3"
			
			## Ingresando a i3WM.sh
			cd ./WM/i3WM/
			./i3WM.sh

			## Regresando a la posicion de main
			cd ..
			cd ..
			
			break
			;;
		4)
			echo "## > Se selecciono, sin WM"
			break
			;;
		*)
			echo "Valor invalido, reintentalo nuevamente"
			continue
			;;
	esac
done







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







echo "############################ OTRAS APPS #############################"
./system/myApps.sh 


