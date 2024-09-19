#!/usr/bin/env bash

source ./variables.sh

echo "
########################################################################
############################### SKEL ###################################
########################################################################
"



## Creacion de la carpeta por si no existe
mkdir -p /etc/skel

## Copia de home's
cp -r ./sesion/skel/ /etc/
cp -r ./sesion/live/ /home/

## Ajuste de permisos
chown live /home/live -R




if [ "systemd" == "${init}" ]
then
	echo "
	########################################################################
	############################  CALAMARES ################################
	########################################################################
	"

	## Icono de la aplicacion calamares (48x48.png)
	#cp ./???.png /usr/share/icons/hicolor/48x48/apps/???.png


	## Aplicacion
	#cp ./calamares.desktop /home/live/Desktop/Instalar.desktop
	
	## Configuracion general
	cp ./instaladorCalamares/settings.conf /etc/calamares/

	## MODULO: Remover usuario live
	cp ./instaladorCalamares/removeuser.conf /etc/calamares/modules/

	## MODULO: Añadidos en la seleccion de particiones
	cp ./instaladorCalamares/partition.conf /etc/calamares/modules/
	
	## Se añade la linea para eliminar usuario
	if grep -q "  - removeuser" /etc/calamares/settings.conf
	then
	
		echo "El ajuste '## Se añade la linea para eliminar usuario' existe, omitiendo este paso..."
		
	else
	perl -i -pe '
		BEGIN { $count = 0 } 
		if (/keyboard/) { 
			$count++; 
			if ($count == 2) { 
				print "  - removeuser\n" 
			} 
		}' /etc/calamares/settings.conf
	fi


	echo "
	########################################################################
	########################## DISPLAY MANAGER #############################
	########################################################################
	"
	
	sed -i '/autologin-user=/c autologin-user=live' /etc/lightdm/lightdm.conf
	sed -i '/autologin-user-timeout=/c autologin-user-timeout=0' /etc/lightdm/lightdm.conf
	sed -i '/autologin-session=/c autologin-session=icewm-session' /etc/lightdm/lightdm.conf
	


fi


echo "
########################################################################
############################## A ELIMINAR ##############################
########################################################################
"

##apt -y remove aspell-es chafa cups-pk-helper debian-reference-es debian-reference-common fonts-liberation ispanish task-spanish manpages-es system-config-printer system-config-printer-common python3-gi-cairo python3-cairo system-config-printer-udev python3-cupshelpers python3-cups python3-smbc 
##blueman

echo "
########################################################################
############################## HOSTNAME ################################
########################################################################
" 

echo "${nombreDistro}" > /etc/hostname




echo "
########################################################################
######################### AJUSTES USUARIO LIVE #########################
########################################################################
" 

####### PRIVILEGIOS
if grep -q "live    ALL=(ALL:ALL) ALL" /etc/sudoers 
then

	echo "Existe ajuste, omitiendo este paso..."
	
else

	sed -i '/root	ALL=(ALL:ALL) ALL/a live    ALL=(ALL:ALL) ALL' /etc/sudoers 

fi


######## AJUSTE RESOLUCION
if grep -q "sh -c 'xrandr --output Virtual-1 --mode 1360x768'" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "
sh -c 'xrandr --output Virtual-1 --mode 1360x768'" >>  /home/live/.icewm/startup 

fi
########## LOGIN SIN CONTRASEÑA (systemd)










if [ "sysvinit" == "${init}" ]
then

	echo "
	########################################################################
	############################## SYSVINIT ################################
	########################################################################
	"
	
	echo "
	########################################################################
	#################### AJUSTES SCRIPTS ARANQUE ###########################
	########################################################################
	"
	## Gestionar los scripts de inicio de los servicios en sistemas basados en SysVinit. 
	## insserv lee los archivos de configuración de los servicios y asegura que se inicien
	## en el orden correcto, de acuerdo con sus dependencias.
	#apt -y install insserv
		
	## Se elimina la monitoriza los discos duros (SMART)
	insserv -r smartd

	## Se elimina una herramienta de seguridad que restringe las capacidades 
	## de los programas mediante el uso de perfiles de seguridad.
	insserv -r apparmor

	## Se elimina una herramientas para controlar y monitorear discos duros utilizando SMART.
	insserv -r smartmontools
	
	
	
	echo "
	########################################################################
	######################### AJUSTES USUARIO LIVE #########################
	########################################################################
	" 
	
	########## LOGIN SIN CONTRASEÑA (sysVinit)
	## Ajuste al archivo
	##sed -i '/1:2345:respawn:\/sbin\/getty/c 1:2345:respawn:\/sbin\/getty -a live --noclear 38400 tty1' /etc/inittab

	## Aplicando cambios
	##sudo init q
	
	
	########## Ajustando numero de tty's (sysVinit)
	## Ajuste al archivo
	sed -i '/4:23:respawn:\/sbin\/getty/c #4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
	sed -i '/5:23:respawn:\/sbin\/getty/c #5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
	sed -i '/6:23:respawn:\/sbin\/getty/c #6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab

	## Aplicando cambios
	sudo init q
	
	
	
	
	
	
	
	
	
	

	##apt -y install seatd 
	
fi














#reboot
