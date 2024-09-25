#!/bin/bash

remove="sudo apt -y remove --purge"

y="-y"


function appsBloat(){






echo "
########################################################################
                    ELIMINACION APPS INNECESARIAS
########################################################################
"

appBloat=(


	##  Ejecución programada de tareas
	anacron
	
	## Accesibilidad 
	at-spi2-core
	
	## Intercepta crasheos de primera vez
	apport 
	
	## Permite a los dispositivos de una red local encontrar y comunicarse entre sí sin necesidad de configuración manual.
	avahi-* 
	
	## Es responsable de la recopilación de datos de uso de recursos del sistema, como la CPU, la memoria, el disco y la red, para su posterior análisis y generación de informes.
	atop
	
	## IDE VSCode open source"
	codium 

	## Servicio gnome para calendario, chat, documentos, correo 
 	evolution-data-server*   
 	
	## CUPS (Common Unix Printing System) es un sistema de impresión utilizado en sistemas operativos Unix y Linux. 
	## (Proporciona una interfaz para gestionar trabajos de impresión y compartir impresoras en red.) 
	cups*
	
 	## Editor de texto
 	gedit 	
 	
 	## Gnome
	gnome-shell-common
	gnome-remote-desktop
	gnome-terminal
	gdm3
	
 	## Integra cuentas de servicios en línea (como Google, Microsoft, Nextcloud y otros) en el entorno de escritorio GNOME.
 	gnome-online-accounts
	
	##
	gpg-agent 	
	
	
	## Entropia adicional
	haveged
		
 	##
	ibus*
	
	## Distribuir de manera equilibrada las interrupciones de hardware (IRQ) entre los núcleos de CPU disponibles. 
	irqbalance
	
	##  Registra y reporta errores del núcleo
	kerneloops 
	
	
	## Protocolo de impresión en red que permite a las computadoras enviar trabajos de impresión a impresoras conectadas en red (aparece como lpd)
	lpr
	
	## Volumenes logicos
	lvm2*
	
	## Una interfaz para gestionar conexiones de módem, redes móviles (3G, 4G, LTE)
	modemmanager  

	## Supervisa y gestiona/optimiza almacenamiento 
	multipath-tools*
	
	## Monitorizacion de temperatura, voltajes y velocidades de los ventiladores
	lm-sensors
	
	## Contenedores
	lxcfs
	
	## Administracion unificada de contenedores y maquinas virtuales
	lxd-*

	
	## Es un protocolo VPN de código abierto que utiliza técnicas de red privada virtual (VPN) para establecer conexiones seguras de sitio a sitio o de punto a punto
	openvpn 
	

	## Es la implementación de código abierto de VMware Tools para sistemas operativos invitados Linux y FreeBSD.
	open-vm-tools	


	## Protocolo de la capa de transporte, definido en las especificaciones SCSI-3, usado para conectar un dispositivo de almacenamiento vía Ethernet a un servidor.
	open-iscsi


	## Intalador de paquetes facil y grafico" 
	packagekit*
	
	## Gestión de servicios en el sistema de transporte QRTR (Qualcomm Remote Transport).
	qrtr-tools

	## Generacion de numeros, Criptografia, seguridad
	rng-tools*
	
	## Contiene definiciones de protocolos para el Sistema de Llamadas a Procedimientos Remotos 
	## (permite que un programa ejecute código en otro proceso (posiblemente en otra máquina) como si fuera una llamada a una función local)
	rpcsvc-proto 

	## Recopilar, procesa y almacena mensajes de registro (logs) generados por el sistema y las aplicaciones.
	rsyslog 

	## Mejora la gestión de prioridades en el sistema de audio, especialmente en entornos donde se requieren latencias bajas
	rtkit
	
	## Cliente de escritorio remoto 
	remmina*	

	## Permite la interoperabilidad entre sistemas Linux/Unix y sistemas Windows, facilitando el intercambio de archivos e impresoras en una red. 
	samba 

 	## Sistema de gestión de paquetes para aplicaciones en Linux, que permite instalar, actualizar y eliminar aplicaciones en formato Snap. 
 	snapd	
 	
 	## Gestiona el cambio entre gráficos integrados y dedicados en sistemas con múltiples GPUs (como laptops) 
 	switcheroo-control  
 	
	## Monitoriza y controla procesos antes del OOM (Out Of Memory) en el espacio del kernel
	systemd-oomd
 	
	## SMART Disk Monitoring Daemon
	smartmontools
	
	## Proporcionar una experiencia de escritorio remoto optimizada y está comúnmente utilizado en entornos de virtualización, como KVM/QEMU.
	spice-vdagent 
	
	## Permite el acceso a escáneres de imágenes a través de la red.
	sane*
	
	## Conjunto de herramientas de monitoreo de rendimiento en sistemas Linux. 
	## Información detallada sobre CPU, memoria, discos, red, etc.
	sysstat 
	
	## Servicio que proporciona una interfaz para que las aplicaciones conviertan texto en habla
	speech-dispatcher*
	
	## Proporciona herramientas y scripts para facilitar la gestión de certificados SSL/TLS.
	ssl-cert

	## Terminales
	xterm
	gnome-terminal

	## Thunderbird"
	thunderbird 

	## Sistema de indexación y búsqueda de contenido para entornos de escritorio en Linux, especialmente utilizado en el entorno GNOME
	tracker*	
	
	## Servicio de generación de miniaturas
	tumbler*
	
	## Actualizador de paquetes facil y grafico"
	update-manager 
	
	## Gestiona perfiles de energía en sistemas Linux (comunmente en GNOME)
	power-profiles-daemon 

	## paquete de servicio de Canonical para Ubuntu. Ofrece asistencia por niveles para implementaciones de escritorio, servidor y en la nube.
	ubuntu-advantage*
	
	## 
 	ubuntu-pro-client*
 	ubuntu-release*
	
	## Actualizaciones desatendidas
	unattended-upgrades 
	
	## Vim"
	vim* 
	
	## Monotoriza y registra el trafico de red
	vnstat
	
	## VMWare
	vmware*
	
	
	## Reporte de errores ubuntu"
	whoopsie 

	## Reporte de hardware"
	ubuntu-report 

	## Servicio en Linux que actúa como un intermediario entre las aplicaciones y el entorno de escritorio, facilitando la interacción de aplicaciones con funciones específicas del entorno.
	## Proporcionar una API unificada para que las aplicaciones accedan a características del sistema, como diálogos de archivo, selección de archivos, y permisos de acceso a la cámara o el micrófono, etc.
	xdg-desktop-portal
	xdg-desktop-portal-gtk
	
	
	## Backend específico
	xdg-desktop-portal-gnome

	##
	##upower 
	
	##
	##colord

)





for package in "${appBloat[@]}"
do

	echo "
	-------------------------------------------
	::::: Desinstalando $package...
	-------------------------------------------
	"
	
	$remove $package
	

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
		systemd-journald.socket
		
		## Registra errores del kernel
		systemd-pstore.service
		
	
		## //////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		
		
		## Permite el funcionamiento del entorno en vivo de Ubuntu, facilitando su uso y gestión de archivos temporales o persistentes.
		## casper.service 
		
		## Está relacionado con el sistema de archivos ext4 y forma parte de la funcionalidad de mantenimiento automático de los sistemas de archivos
		## e2scrub_reap.service 
		
		##  Se encarga de ejecutar scripts o tareas finales después de que se han montado todos los sistemas de archivos y antes de que el sistema esté completamente operativo.
		## finalrd.service  
		
		## Se encarga de inicializar el espacio de swap
		## mkswap.service
		
		## Se asegura de que ciertas configuraciones y funcionalidades relacionadas con los procesos se inicialicen adecuadamente durante el arranque. ( Permite el uso de herramientas como ps, top, y vmstat)
		## procps.service
		
		## Una herramienta popular para la sincronización de archivos y directorios entre sistemas locales y remotos
		## rsync.service 
		
		## Se encarga de configurar el color del fondo de la terminal virtual (VT) al iniciar el sistema.
		## setvtrgb.service  
		

		## Registros
		dmesg.service

		## Gestión de la cámara en dispositivos que utilizan la pila de control de cámaras de Rockchip.
		rkaiq_3A.service

				



		

		
		### SNAP
		#snapd.apparmor.service
		#snapd.apparmor.service
		#snapd.autoimport.service
		#snapd.core-fixup.service
		#snapd.failure.service  
		#snapd.recovery-chooser-trigger.service 
		#snapd.seeded.service      
		#snapd.service          
		#snapd.snap-repair.service
		#snapd.system-shutdown.service
		#snap.lxd.activate.service
		
		### Es el componente del sistema que gestiona las conexiones SSH entrantes y salientes en el servidor.
		#sshd

		### Acceso y transferecias de archivos de sistemas remotos de forma segura
		#ssh.service 
		
		### Almacenamiento y administracion segura de las llaves SSH 
		#gcr-ssh-agent.service
		#gcr-ssh-agent.socket
		
		#snapd.socket
		#ssh.socket
		#systemd-oomd.socket
		#whoopsie.path

		
		
		## ---------------------------------------------------
		
		
	

		
		## Investigar
		#mkswap.service


		
	)

	mask="sudo systemctl mask"

	for app in "${servicesBloatMask[@]}"
	do

		
		echo "
		-------------------------------------------
		::::: Enmascarando $app...
		-------------------------------------------
		"
		$mask $app

	done


	## systemctl --user mask ssh-agent.service ## PENDIENTE INVESTIGAR  





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

		
		echo "
		-------------------------------------------
		::::: Deshabilitando $app...
		-------------------------------------------
		"
		$disable $app


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
	
	## Administrar las sesiones de usuario, controlar el acceso a los recursos del sistema y gestionar las políticas de inicio de sesión en el sistema.
	#systemd-logind

	## Gestion centralizada de la configuracion del escritorio
	#dconf-service

	## Gestion centralizada de contraseñas y claves de forma segura
	#gnome-keyring-daemon

	## Es un agente para la gestión de claves y la realización de operaciones criptográficas en el sistema.
	#gpg-agent

	## Sincronizacion del reloj preciso
	#chronyd	
	
	## Es un servicio y herramienta en sistemas Linux que simula un reloj de hardware.
	## Util en sistemas que no tienen un reloj de hardware (RTC) real o en aquellos donde el reloj de hardware no es confiable.
	##fake-hwclock
		
}

######################### Seccion para systemd ######################### 
if [ $(ps -p 1 -o comm=) ==  "systemd" ]
then
		echo "
		-------------------------------------------
		::::: INIT IDENTIFICADO: --systemd-- 
		-------------------------------------------
		"


		
		if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "Y" ] || [ "$isBluetooth" == "" ]
		then
			echo "
			------------------------------------------------------------------
			:::::  Bluetooth permitido, no se removera el servicio Bluetooth
			------------------------------------------------------------------
			"
		else
			echo "
			-----------------------------------------------
			:::::  Deshabilitando servicio bluetooth...
			-----------------------------------------------
			"
			sudo systemctl disable bluetooth.service
		fi
		
		
		
		
		######################### Validacion debloat #########################  
		if [ "$isDebloat" == "y" ] || [ "$isDebloat" == "Y" ] ||  [ "$isDebloat" == "" ]
		then
			appsBloat
			
		echo "
		-------------------------------------------
		::::: LISTO
		-------------------------------------------
		"
		else
		
		echo "
		-------------------------------------------
		::::: 'Debloat' marcado para no instalar
		-------------------------------------------
		"
		
		fi


######################## Seccion para sysvinit ######################### 
elif [ $(ps -p 1 -o comm=) ==  "init" ]; then
		
		echo "
		-------------------------------------------
		::::: INIT IDENTIFICADO: --sysvinit-- 
		-------------------------------------------
		"
		
		
		if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "Y" ] || [ "$isBluetooth" == "" ]
		then
			echo "
			------------------------------------------------------------------
			::::: Bluetooth permitido, no se removera el servicio Bluetooth
			------------------------------------------------------------------
			"
			
		else

			echo "
			-------------------------------------------------------
			::::: Deshabilitando servicio bluetooth...
			-------------------------------------------------------
			"
			sudo update-rc.d -f bluetooth remove
		fi
		
		
		
		
		######################### Validacion debloat #########################  
		if [ "$isDebloat" == "y" ] || [ "$isDebloat" == "Y" ] || [ "$isDebloat" == "" ]; then		
			

			echo "
			-------------------------------------------------
			:::::  Deshabilitando otros servicios...
			-------------------------------------------------
			"

			sudo update-rc.d -f cron remove
			sudo update-rc.d -f avahi-daemon remove
			sudo update-rc.d -f ofono remove
			sudo update-rc.d -f dundee remove

			
			## Optimizar getty
			## Solo 2 tty's
			#sudo sed -i '/2:23:respawn:\/sbin\/getty 38400 tty2/c #2:23:respawn:\/sbin\/getty 38400 tty2' /etc/inittab
			sudo sed -i '/3:23:respawn:\/sbin\/getty 38400 tty3/c #3:23:respawn:\/sbin\/getty 38400 tty3' /etc/inittab
			sudo sed -i '/4:23:respawn:\/sbin\/getty 38400 tty4/c #4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
			sudo sed -i '/5:23:respawn:\/sbin\/getty 38400 tty5/c #5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
			sudo sed -i '/6:23:respawn:\/sbin\/getty 38400 tty6/c #6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab

			echo "
			------------------------------------------
			:::::  LISTO
			-----------------------------------------
			"
		
		else
			
			echo "
			-------------------------------------------
			::::: 'Debloat' marcado para no instalar
			-------------------------------------------
			"
			
		fi
fi
