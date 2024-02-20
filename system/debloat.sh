#!/bin/bash

#function askPolkitGnome(){
	#if [ "$isPolkit" == "true" ]; then
		#echo "## No se removera el servicio policykit-1-gnome"
	#else
		#echo "## Deshabilitando servicio 'policykit-1-gnome'"
		#sudo chmod -x /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 

	#fi
#}



	echo '########## ¿¿DEBLOAT?? ##########'

######################### Seccion para systemd ######################### 
if [ $(ps -p 1 -o comm=) ==  "systemd" ]; then
		echo "systemd detectado"

		
		if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then
			echo "## Bluetooth permitido, no se removera el servicio Bluetooth"
		else
			echo "## Deshabilitando servicio bluetooth"
			sudo systemctl disable bluetooth.service
		fi
		
		######################### Validacion debloat #########################  
		if [ "$isDebloat" == "y" ] || [ "$isDebloat" == "Y" ] ||  [ "$isDebloat" == "" ]; then
			
			echo "## Deshabilitando otros servicios..."
			sudo systemctl disable avahi-daemon.service 
			sudo systemctl disable cron.service 
			sudo systemctl disable anacron.service
			sudo systemctl disable ModemManager.service

			## Accesibilidad
			systemctl --user mask at-spi-dbus-bus.service
			systemctl --user mask at-spi2-registryd.service
				
			## Polkit 
			#askPolkitGnome
			
			sudo systemctl disable libvirt-guests.service
			sudo systemctl disable libvirtd.service
			
			: "
			## Investigando...
			sudo systemctl disable lm-sensors.service 
			sudo systemctl disable lvm2-monitor.service 
			sudo systemctl disable blk-availability.service
			sudo systemctl disable systemd-pstore.service
			sudo systemctl mask rtkit-daemon.service
			"
			
			echo "## Listo"
		else
		
			echo "## 'debloat' marcado para no instalar"
		
		fi


######################## Seccion para sysvinit ######################### 
elif [ $(ps -p 1 -o comm=) ==  "init" ]; then
		
		echo "sysVinit detectado"

		
		if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then
			echo "## Bluetooth permitido, no se removera el servicio Bluetooth"
		else
			echo "## Deshabilitando servicio bluetooth"
			sudo update-rc.d -f bluetooth remove
		fi
		
		######################### Validacion debloat #########################  
		if [ "$isDebloat" == "y" ] || [ "$isDebloat" == "Y" ] ||  [ "$isDebloat" == "" ]; then		
			
			echo "## Deshabilitando otros servicios..."
			sudo update-rc.d -f cron remove
			sudo update-rc.d -f avahi-daemon remove
			sudo update-rc.d -f ofono remove
			sudo update-rc.d -f dundee remove
			sudo update-rc.d -f network-manager remove
			
			## Servicios de accesibilidad...
			sudo chmod -x /usr/libexec/at-spi-bus-launcher 
			sudo chmod -x /usr/libexec/at-spi2-registryd 
			
			## Libvirt
			sudo update-rc.d -f libvirt-guests remove
			sudo update-rc.d -f libvirtd remove
			
			## Optimizar getty
			## Solo 1 tty
			sudo sed -i '/2:23:respawn:\/sbin\/getty 38400 tty2/c#2:23:respawn:\/sbin\/getty 38400 tty2' /etc/inittab
			sudo sed -i '/3:23:respawn:\/sbin\/getty 38400 tty3/c#3:23:respawn:\/sbin\/getty 38400 tty3' /etc/inittab
			sudo sed -i '/4:23:respawn:\/sbin\/getty 38400 tty4/c#4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
			sudo sed -i '/5:23:respawn:\/sbin\/getty 38400 tty5/c#5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
			sudo sed -i '/6:23:respawn:\/sbin\/getty 38400 tty6/c#6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab

			## Polkit Gnome
			#askPolkitGnome
			
			: "
			## INVESTIGANDO...
			sudo update-rc.d -f systemd-pstore remove
			sudo update-rc.d -f lm-sensors remove
			sudo update-rc.d -f lvm2-monitor remove
			sudo update-rc.d -f blk-availability remove
			sudo update-rc.d -f rtkit-daemon remove
			"
			
			echo "## Listo"
		
		else
			
			echo "## 'debloat' marcado para no instalar"
			
		fi
fi
