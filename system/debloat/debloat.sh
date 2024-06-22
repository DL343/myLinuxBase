#!/bin/bash

remove="sudo apt remove --purge"

y="-y"


function appsBloat(){






echo "
########################################################################
                    ELIMINACION APPS INNECESARIAS
########################################################################
"

appBloat=(


	## Intalador de paquetes facil y grafico" 
	packagekit*

	## Actualizador de paquetes facil y grafico"
	update-manager 

	## Thunderbird"
	thunderbird 

	## Intercepta crasheos de primera vez"
	apport 

	## Reporte de errores ubuntu"
	whoopsie 

	## Reporte de hardware"
	ubuntu-report 

	## Terminales"
	terminator 
	xterm
	gnome-terminal

	## IDE VSCode open source"
	codium 

	## Vim"
	vim* 

	## ?????
	samba

	## ?????
	avahi* 

	## Es un protocolo VPN de código abierto que utiliza técnicas de red privada virtual (VPN) para establecer conexiones seguras de sitio a sitio o de punto a punto
	openvpn 

	## paquete de servicio de Canonical para Ubuntu. Ofrece asistencia por niveles para implementaciones de escritorio, servidor y en la nube.
	ubuntu-advantage*
	
	##  Programas y controladores necesarios para el funcionamiento del Servidor Cloud
	open-vm-tools
	
	## Servicio gnome para calendario, chat, documentos, correo 
 	evolution-data-server*
 	gnome-online-accounts 
 	
 	## 
 	ubuntu-pro-client*
 	ubuntu-release*
 	
 	## Editor de texto
 	gedit
 	
 	## 
 	snapd

	##
	cups*
	
	##
	ibus*
	
	## Gnome
	gnome-shell-common
	tracker*
	gnome-remote-desktop
	
	
	## The Tracker project is a open community of developers who maintain an efficient, privacy-respecting desktop search engine, available as Free Software.
	tracker-miner-fs
	
	##
	remmina*

)



for package in "${appBloat[@]}";
do

	union="$remove $package $y" 
	echo "
	-------------------------------------------
	Desinstalando $package...
	-------------------------------------------
	"
	$union

done








echo "
####################################################################
                      ENMASCARANDO SERVICIOS
####################################################################
"
	servicesBloatMask=(

		## ------ DEBIAN BASE ------- ##
		
		## De forma centralizada registra los registros del sistema y servicios
		systemd-journald.service 
		
		
		## Es un servicio de programación de tareas
		cron
		anacron.service 
		
		## Gestion de redes 2G/3G/4G/5G (Configuracion de Gnome se rompe)
		ModemManager.service
		
		## Registra errores del kernel
		systemd-pstore.service
		
		##
		avahi-daemon.service
		avahi-daemon.socket
		

		
		
		
		
		## //////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		
		
		
		## Es un servicio del sistema que hace mas facil administrar, instalar, generar perfiles de color.
		colord.service


		## Gestiona la bateria y energia
		upower.service
		
		## Impresion 
		cups.service 
		cups.browsed.service
		cups-browsed.service
		
		## Registro y envio de errores
		apport.service
				
		## Volumenes logicos
		lvm2.service
		lvm2-monitor.service
		
		## Permite cambiar en diferentes perfiles de energia
		power-profiles-daemon.service 
		

		
		## Gestion de paquetes de software
		packagekit.service
		
		## SNAP
		snapd.apparmor.service
		snapd.apparmor.service
		snapd.autoimport.service
		snapd.core-fixup.service
		snapd.failure.service  
		snapd.recovery-chooser-trigger.service 
		snapd.seeded.service      
		snapd.service          
		snapd.snap-repair.service
		snapd.system-shutdown.service
		snap.lxd.activate.service

		## OpenVPN
		openvpn.service

		## Es responsable de la recopilación de datos de uso de recursos del sistema, como la CPU, la memoria, el disco y la red, para su posterior análisis y generación de informes.
		##atop
		##  |----> atopacctd
		atop
		atopacct.service 

		## Es el componente del sistema que gestiona las conexiones SSH entrantes y salientes en el servidor.
		sshd

		## Gestion de paquetes de software
		packagekit.service 

		## Entropia adicional / Generacion de numeros, Criptografia, seguridad
		haveged
		rng-tools
		rng-tools-debian.service

		## Monotoriza y registra el trafico de red
		vnstat.service 

		## Acceso y transferecias de archivos de sistemas remotos de forma segura
		ssh.service 

		## Es un servicio de llamadas a procedimientos remotos
		rpcbind.service 

		## Actualizaciones desatendidas
		unattended-upgrades.service 

		## Gestiona la impresora
		lpd

		## Registra los mensajes del sistema
		rsyslog.service 

		## Soporte empresarial de Ubuntu Pro, soporte tecnico
		ubuntu-advantage.service 

		## Supervisa y gestiona/optimiza almacenamiento 
		multipathd.service

		## Toggle gpu integrada y dedicada
		switcheroo-control

		## Registro y envio de errores en el kernel
		kerneloops

		## Contenedores
		lxcfs.service 

		## Es el uso de componentes de red de almacenamiento responsables del proceso de transferencia de datos entre el servidor y el almacenamiento
		multipathd.service

		## Permite a los programas acceder y administrar la información de las cuentas de usuario a través de D-Bus de forma estandarizada, sin importar cómo se proporcionen realmente al sistema.
		#accounts-daemon.service
			
		## DM
		gdm3

		## Sensores
		lm-sensors.service 

		## Camaras 
		rkaiq_3A.service
		rkisp_3A.service
		
		## Asistencia ubuntu-advantage
		ua-reboot-cmds.service

		## Servicio de VMWare
		vgauth.service

		## Administracion unificada de contenedores y maquinas virtuales
		lxd-agent.service
		
		## Protocolo de la capa de transporte, definido en las especificaciones SCSI-3, usado para conectar un dispositivo de almacenamiento vía Ethernet a un servidor.
		open-iscsi.service
		
		## Es la implementación de código abierto de VMware Tools para sistemas operativos invitados Linux y FreeBSD.
		open-vm-tools.service
		
		## SMART Disk Monitoring Daemon
		smartmontools.service 
		
		## Acceso remoto
		gnome-remote-desktop.service
		
		## ???
		qrtr-ns.service
		
		## Monitoriza y controla procesos antes del OOM (Out Of Memory) en el espacio del kernel
		systemd-oomd.service
		
		## 
		accounts-daemon.service
		
		
		
		## ---------------------------------------------------
		
		
		
		

		
		## Almacenamiento y administracion segura de las llaves SSH 
		gcr-ssh-agent.service
		gcr-ssh-agent.socket
		
		## 
		irqbalance.service

		## Registros
		dmesg.service
		
		cups.path
		cups.socket
		snapd.socket
		ssh.socket
		systemd-oomd.socket
		whoopsie.path


		fake-hwclock-save.service
		fake-hwclock-load.service
		
		
		## Investigar
		#fake-hwclock.service
		#fake-hwclock-save.timer
		#mkswap.service


		
	)

	mask="sudo systemctl mask"

	for app in "${servicesBloatMask[@]}"
	do

		union="$mask $app"
		echo "
		-------------------------------------------
		Enmascarando $app...
		-------------------------------------------
		"
		$union

	done


	## systemctl --user mask ssh-agent.service ## PENDIENTE INVESTIGAR  

	## Soporte para la accesibilidad / asistencia
	systemctl --user mask at-spi-dbus-bus.service 
	systemctl --user mask at-spi2-registryd.service




echo "
###################################################################
                   DESHABILITANDO SERVICIOS
###################################################################
	"

	servicesBloatDisable=(



	)

	disable="sudo systemctl disable"


	for app in "${servicesBloatDisable[@]}"
	do

		union="$disable $app"
		echo "
		-------------------------------------------
		Deshabilitando $app...
		-------------------------------------------
		
		
		"
		
		$union


	done



	################################################

	## Proporciona la funcionalidad del Bluetooth
	#bluetooth.service

	## Mantiene el reloj del sistema sincronizado con un servidor de tiempo de red, lo que asegura que la hora del sistema sea precisa y esté actualizada.
	#systemd-timesyncd

	##  Su función principal es proporcionar una forma de configurar la red de forma dinámica y flexible, reemplazando a los tradicionales sistemas de configuración de red como "ifupdown" en sistemas Debian o "network" en sistemas Red Hat.
	#systemcd-networkd

	## Proporciona una resolución de DNS eficiente y flexible, así como una gestión avanzada de la configuración de DNS.
	#systemd-resolved

	## Administrar los dispositivos en el sistema, incluyendo la detección, creación y gestión dinámica de los nodos de dispositivo en el directorio /dev.
	#systemd-udevd

	## Gestion robusta y automatizada de los dispositivos de almacenamiento y mejorando la disponibilidad, el rendimiento y la tolerancia a fallos del sistema.
	#multipathd

	## Gestion centralizada de la configuracion del escritorio
	#dconf-service

	## Gestion centralizada de contraseñas y claves de forma segura
	#gnome-keyring-daemon

	## Administrar las sesiones de usuario, controlar el acceso a los recursos del sistema y gestionar las políticas de inicio de sesión en el sistema.
	#systemd-logind

	## fwupd (Firmware Update) 
	## permite a los usuarios mantener actualizados los microcódigos, firmware y BIOS de diversos dispositivos de hardware en sus sistemas Linux, como placas base, tarjetas de red, unidades SSD, teclados, ratones y otros periféricos compatibles.
	#fwupd

	## es un agente para la gestión de claves y la realización de operaciones criptográficas en el sistema.
	#gpg-agent

	## Sincronizacion del reloj preciso
	#chronyd


	## ?????????????????????
	# hwrng	
		
}

######################### Seccion para systemd ######################### 
if [ $(ps -p 1 -o comm=) ==  "systemd" ]
then
		echo "systemd detectado"



		
		if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then
			echo "## Bluetooth permitido, no se removera el servicio Bluetooth"
		else
			echo "## Deshabilitando servicio bluetooth"
			sudo systemctl disable bluetooth.service
		fi
		
		
		
		
		######################### Validacion debloat #########################  
		if [ "$isDebloat" == "y" ] || [ "$isDebloat" == "Y" ] ||  [ "$isDebloat" == "" ]
		then
			appsBloat
			
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

			
			## Optimizar getty
			## Solo 1 tty
			sudo sed -i '/2:23:respawn:\/sbin\/getty 38400 tty2/c#2:23:respawn:\/sbin\/getty 38400 tty2' /etc/inittab
			sudo sed -i '/3:23:respawn:\/sbin\/getty 38400 tty3/c#3:23:respawn:\/sbin\/getty 38400 tty3' /etc/inittab
			sudo sed -i '/4:23:respawn:\/sbin\/getty 38400 tty4/c#4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
			sudo sed -i '/5:23:respawn:\/sbin\/getty 38400 tty5/c#5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
			sudo sed -i '/6:23:respawn:\/sbin\/getty 38400 tty6/c#6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab

			echo "## Listo"
		
		else
			
			echo "## 'debloat' marcado para no instalar"
			
		fi
fi
