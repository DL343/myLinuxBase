#!/bin/bash

echo '########## ¿¿DEBLOAT?? ##########'

if [ $(ps -p 1 -o comm=) ==  "systemd" ]; then
		echo "systemd detectado"
		echo "Removiendo servicios..."
		
		if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then
			echo "## Bluetooth permitido, no se removera el servicio Bluetooth"
		else
			echo "## Deshabilitando servicio bluetooth"
			sudo systemctl disable bluetooth.service
		fi
		
		echo "## Deshabilitando otros servicios..."
		sudo systemctl disable avahi-daemon.service 
		sudo systemctl disable cron.service 
		sudo systemctl disable anacron.service
		sudo systemctl disable ModemManager.service
		
		
		## Investigando...
		sudo systemctl disable rtkit-daemon
		systemctl --user mask at-spi-dbus-bus.service
		systemctl --user mask at-spi2-registryd.service

		## Polkit
		sudo systemctl mask polkit.service 
		
		## Otros...
		sudo systemctl disable systemd-pstore.service 
		sudo systemctl disable lm-sensors.service 
		sudo systemctl disable lvm2-monitor.service 
		sudo systemctl disable blk-availability.service
		
		## Libvirt
		sudo systemctl disable libvirt-guests.service
		sudo systemctl disable libvirtd.service
		
		## Investigando
		
		sudo systemctl mask rtkit-daemon.service


	elif [ $(ps -p 1 -o comm=) ==  "init" ]; then
	
		echo "sysVinit detectado"
		echo "Removiendo servicios..."
		
		if [ "$blueFlag" == "true" ]; then
			echo "No se removera el servicio Bluetooth"
		else
			echo "Deshabilitando servicio bluetooth"
			sudo update-rc.d -f bluetooth remove
		fi
		
		echo "## Deshabilitando otros servicios..."
		sudo update-rc.d -f cron remove
		sudo update-rc.d -f avahi-daemon remove
		sudo update-rc.d -f ofono remove
		sudo update-rc.d -f dundee remove
		sudo update-rc.d -f network-manager remove
		
		## Servicios de accesibilidad...
		sudo update-rc.d -f at-spi-dbus-bus remove 		
		sudo update-rc.d -f at-spi2-registryd remove

		## Polkit
		sudo update-rc.d -f polkit remove
		
		## Otros...
		sudo update-rc.d -f systemd-pstore remove
		sudo update-rc.d -f lm-sensors remove
		sudo update-rc.d -f lvm2-monitor remove
		sudo update-rc.d -f blk-availability remove
		
		sudo chmod -x /usr/libexec/at-spi-bus-launcher 
		sudo chmod -x /usr/libexec/at-spi2-registryd 
		
		## Investigando...
		sudo update-rc.d -f rtkit-daemon remove
		
		## Libvirt
		sudo update-rc.d -f libvirt-guests remove
		sudo update-rc.d -f libvirtd remove
		
		## Optimizar getty
		## Solo 2 tty
		sudo sed -i '/3:23:respawn:\/sbin\/getty 38400 tty3/c#3:23:respawn:\/sbin\/getty 38400 tty3' /etc/inittab
		sudo sed -i '/4:23:respawn:\/sbin\/getty 38400 tty4/c#4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
		sudo sed -i '/5:23:respawn:\/sbin\/getty 38400 tty5/c#5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
		sudo sed -i '/6:23:respawn:\/sbin\/getty 38400 tty6/c#6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab




		
		echo "## Listo"
fi



