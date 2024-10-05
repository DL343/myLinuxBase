#!/usr/bin/env bash

source ./variables.sh

if [ 'y' == "${custom}"  ]
then



	
	
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

























fi

