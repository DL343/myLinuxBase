#!/usr/bin/env bash


source ./variables.sh

if [ "sysvinit" == "${init}" ]
then
	

fi



if [ "systemd" == "${init}" ]
then
	

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
	
	## ICONOS
	mkdir -p /usr/share/icons/
	cp -r ./custom/icons/* /usr/share/icons/
	
	## CURSOR
	#
	
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
	
	
	## GRUB: Tema
	: ' 

== GRUB_TIMEOUT=5
++ GRUB_DISTRIBUTOR=`lsb_release -d -s 2> /dev/null || echo 'Loc-OS 23 Linux (Con Tutti)'`	

== GRUB_CMDLINE_LINUX=""
++ GRUB_THEME=/boot/grub/themes/custom/theme.txt



	
	' 
	mkdir -p /boot/grub/themes/custom/
	cp -r ./custom/grub_theme/* /boot/grub/themes/custom/
	update-grub
	
	
	
	
	


fi


