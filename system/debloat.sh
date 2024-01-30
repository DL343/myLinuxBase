#!/bin/bash

echo '########## ¿¿DEBLOAT?? ##########'

if [ $(ps -p 1 -o comm=) ==  "systemd" ]; then
		echo "Systemd detectado"
		echo "Removiendo servicios..."
		sudo systemctl disable bluetooth.service 
		sudo systemctl disable avahi-daemon.service 
		sudo systemctl disable cron.service 
		sudo systemctl disable anacron.service
		sudo systemctl disable ModemManager.service 

	elif [ $(ps -p 1 -o comm=) ==  "sysvinit" ]; then
		echo "SysVinit detectado"
		echo "Removiendo servicios..."
		sudo update-rc.d -f cron remove
		sudo update-rc.d -f bluetooth remove
		sudo update-rc.d -f avahi-daemon remove

fi



