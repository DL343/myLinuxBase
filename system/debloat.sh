#!/bin/bash

echo '########## ¿¿DEBLOAT?? ##########'

if [ $(ps -p 1 -o comm=) ==  "systemd" ]; then
		echo "systemd detectado"
		echo "Removiendo servicios..."
		
		if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then
			echo "#### Bluetooth permitido, no se removera el servicio Bluetooth"
		else
			echo "#### Deshabilitando servicio bluetooth"
			sudo systemctl disable bluetooth.service
		fi
		
		sudo systemctl disable avahi-daemon.service 
		sudo systemctl disable cron.service 
		sudo systemctl disable anacron.service
		sudo systemctl disable ModemManager.service 



	elif [ $(ps -p 1 -o comm=) ==  "sysvinit" ]; then
	
		echo "sysVinit detectado"
		echo "Removiendo servicios..."
		
		if [ "$blueFlag" == "true" ]; then
			echo "No se removera el servicio Bluetooth"
		else
			echo "Deshabilitando servicio bluetooth"
			sudo update-rc.d -f bluetooth remove
		fi
		
		sudo update-rc.d -f cron remove
		sudo update-rc.d -f avahi-daemon remove
		sudo update-rc.d -f ofono remove
		sudo update-rc.d -f dundee remove
		sudo update-rc.d -f network-manager remove


fi



