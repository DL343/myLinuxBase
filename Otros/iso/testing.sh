#!/usr/bin/env bash


source ./variables.sh

if [ "sysvinit" == "${init}" ]
then
	
	echo "sysVinit"

fi



if [ "systemd" == "${init}" ]
then

		echo "systemd"

fi











if [ 'y' == "${custom}"  ]
then

	echo "
	########################################################################
	##########################  PERSONALIZACION  ###########################
	########################################################################
	"	

	## TEMAS
	#
	
	## ICONOS + CURSOR
	mkdir -p /usr/share/icons/
	cp -r ./custom/icons/* /usr/share/icons/
	
	## ------------------------------
	
	## WALLPAPERS
	mkdir -p /usr/share/wallpapers/
    cp ./custom/wallpapers/* /usr/share/wallpapers/
	 
	## COLORES
	## /usr/share/color-schemes/
	
	## IMAGEN PERFIL USUARIO
	cp ./custom/face/face.png /etc/skel/.face
	
	## ------------------------------
	
	
	## REFRACTASNAPSHOT: Imagen Arranque Instalacion (640x480).png (Colores oscuros de preferencia)-
	cp ./custom/refracta_Spash/splash.png /usr/lib/refractasnapshot/iso/isolinux/splash.png
	
	
	## PLYMOUTH?
	

	## GRUB: Añadiendo linea para que GRUB reconozca una ruta de temas
	if grep -q "GRUB_THEME=/boot/grub/themes/custom/theme.txt" /etc/default/grub
	then

		echo "Existe 'GRUB_THEME=/boot/grub/themes/custom/theme.txt' omitiendo este paso..."

	else 

		sed -i '/GRUB_CMDLINE_LINUX=""/a GRUB_THEME=/boot/grub/themes/custom/theme.txt' /etc/default/grub

	fi

	## GRUB: Creacion de carpeta
	mkdir -p /boot/grub/themes/custom/
	
	## GRUB: Copiado de temas
	cp -r ./custom/grub_theme/* /boot/grub/themes/custom/
	
	## Copiando background
	cp ./custom/grub_theme/background.jpg /boot/grub/

	## GRUB: Actualizando cambios a GRUB
	update-grub
	

fi


