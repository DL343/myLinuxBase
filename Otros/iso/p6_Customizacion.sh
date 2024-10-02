#!/usr/bin/env bash

source ./variables.sh

if [ 'y' == "${custom}"  ]
then

	echo "
	########################################################################
	##########################  PERSONALIZACION  ###########################
	########################################################################
	"	

	## TEMAS
	mkdir -p /usr/share/themes/
	cp -r ./custom/themes/*      /usr/share/themes/
	
	## ICONOS + CURSOR
	mkdir -p /usr/share/icons/
	cp -r ./custom/icons/*      /usr/share/icons/
	
	## APLICANDO...
	cp ./custom/gtk/.gtkrc-2.0     /etc/skel/.gtkrc-2.0
	cp ./custom/gtk/.gtkrc-2.0     /home/live/.gtkrc-2.0
	
	
	mkdir -p /etc/skel/.config/gtk-3.0/
	mkdir -p /home/live/.config/.config/gtk-3.0/
	cp ./custom/gtk/settings.ini    /etc/skel/.config/gtk-3.0/settings.ini
	cp ./custom/gtk/settings.ini    /home/live/.config/gtk-3.0/settings.ini
	
	
	## IMAGEN PERFIL USUARIO
	cp ./custom/face/*      /etc/skel/.face
	cp ./custom/face/*      /home/live/.face
	
	## ------------------------------
	
	## WALLPAPER PRINCIPAL
	mkdir -p /usr/share/wallpapers/
    cp ./custom/wall/* /usr/share/wallpapers/default.png
    
    ## WALLPAPER'S COMPLEMENTARIOS
    cp ./custom/wallpapers/* /usr/share/wallpapers/
    
	 
	## COLORES
	## /usr/share/color-schemes/
	
	

	
	
	## ------------------------------
	
	
	## REFRACTASNAPSHOT: Imagen Arranque Instalacion (640x480).png (Colores oscuros de preferencia)-
	##cp ./custom/refracta_Splash/* /usr/lib/refractasnapshot/iso/isolinux/splash.png
	
	
	## PLYMOUTH?
	

				## GRUB: Añadiendo linea para que GRUB reconozca una ruta de temas
				if grep -q "GRUB_THEME=/boot/grub/themes/custom/theme.txt" /etc/default/grub
				then

					echo ":::::Existe 'GRUB_THEME=/boot/grub/themes/custom/theme.txt' omitiendo este paso..."

				else 

					sed -i '/GRUB_CMDLINE_LINUX=/a GRUB_THEME=/boot/grub/themes/custom/theme.txt' /etc/default/grub

				fi

				## GRUB: Creacion de carpeta temas
				mkdir -p /boot/grub/themes/custom/
				
				## GRUB: Copiado de tema
				cp -r ./custom/grub_theme/* /boot/grub/themes/custom/
				
				## GRUB: Copiando background
				#cp ./custom/grub_theme/background.jpg /boot/grub/

				## GRUB: Actualizando cambios a GRUB
				update-grub






echo "
########################################################################
################################## ICEWM  ##############################
########################################################################
"	
	
apt -y install xorg
apt -y install icewm --no-install-recommends 
apt -y install sakura   connman-gtk

######## ICEWM: AJUSTE CONFIGURACIONES SOLO EN LIVE
if grep -q "pcmanfm --desktop &" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "
## Escritorio
pcmanfm --desktop &

" >>  /home/live/.icewm/startup 

## Ajuste resolucion pantalla
##sh -c 'xrandr --output Virtual-1 --mode 1280x768' &



########## ICEWM: AJUSTE PERMISOS APAGADO/REINICIO/SUSPENSION
mkdir -p /etc/sudoers.d/

echo "
ALL ALL=(ALL) NOPASSWD: /sbin/reboot
ALL ALL=(ALL) NOPASSWD: /sbin/poweroff
ALL ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend
" > /etc/sudoers.d/icewm
fi



	




















fi

