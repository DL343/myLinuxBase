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
	cp -r ./custom/themes/Adwaita-dark /usr/share/themes/
	
	## ICONOS + CURSOR
	mkdir -p /usr/share/icons/
	cp -r ./custom/icons/* /usr/share/icons/
	
	## ------------------------------
	
	## WALLPAPERS
	mkdir -p /usr/share/wallpapers/
    cp ./custom/wallpapers/* /usr/share/wallpapers/default.png
	 
	## COLORES
	## /usr/share/color-schemes/
	
	## IMAGEN PERFIL USUARIO
	cp ./custom/face/* /etc/skel/.face
	
	## ------------------------------
	
	
	## REFRACTASNAPSHOT: Imagen Arranque Instalacion (640x480).png (Colores oscuros de preferencia)-
	cp ./custom/refracta_Splash/* /usr/lib/refractasnapshot/iso/isolinux/splash.png
	
	
	## PLYMOUTH?
	
		if [ "systemd" == "${init}" ]
		then
				## GRUB: Añadiendo linea para que GRUB reconozca una ruta de temas
				if grep -q "GRUB_THEME=/boot/grub/themes/custom/theme.txt" /etc/default/grub
				then

					echo ":::::Existe 'GRUB_THEME=/boot/grub/themes/custom/theme.txt' omitiendo este paso..."

				else 

					sed -i '/GRUB_CMDLINE_LINUX=""/a GRUB_THEME=/boot/grub/themes/custom/theme.txt' /etc/default/grub

				fi

				## GRUB: Creacion de carpeta temas
				#mkdir -p /boot/grub/themes/custom/
				
				## GRUB: Copiado de temas
				#cp -r ./custom/grub_theme/* /boot/grub/themes/custom/
				
				## GRUB: Copiando background
				cp ./custom/grub_theme/background.jpg /boot/grub/

				## GRUB: Actualizando cambios a GRUB
				update-grub
		fi


	echo "
	########################################################################
	################################## ICEWM  ##############################
	########################################################################
	"	
	
apt -y install xorg
apt -y install sakura   
apt -y install icewm --no-install-recommends 

######## AJUSTE CONFIGURACIONES SOLO EN LIVE
if grep -q "sh -c 'xrandr --output Virtual-1 --mode 1360x768'" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "
## Generacion de carpetas
xdg-user-dirs-update &

## Escritorio
pcmanfm --desktop &

" >>  /home/live/.icewm/startup 

## Ajuste resolucion pantalla
##sh -c 'xrandr --output Virtual-1 --mode 1280x768' &


fi


########## AJUSTE PERMISOS APAGADO/REINICIO/SUSPENSION
#mkdir -p /etc/sudoers.d/

#echo "
#%users ALL=(ALL) NOPASSWD: /sbin/reboot
#%users ALL=(ALL) NOPASSWD: /sbin/poweroff
#%users ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend
#" > /etc/sudoers.d/icewm

	


	
echo "
########################################################################
                              AJUSTE CONNMAN
########################################################################
"

## SKEL
echo '
#!/bin/bash

if pgrep -x "connman-gtk" > /dev/null
then
        pkill connman-gtk
else
        connman-gtk &
fi
' | sudo tee /etc/skel/.config/scripts/toggle_network-applet.sh 



## LIVE
echo '
#!/bin/bash

if pgrep -x "connman-gtk" > /dev/null
then
        pkill connman-gtk
else
        connman-gtk &
fi
' > /home/live/.config/scripts/toggle_network-applet.sh 


sudo chown -R live:live /home/live/





echo "
########################################################################
######################### AJUSTES USUARIO ROOT #########################
########################################################################
" 

## BEACHBIT: CONFIG 
mkdir -p /root/.config/bleachbit/

echo "
[bleachbit]
auto_hide = True
check_beta = False
check_online_updates = False
dark_mode = True
debug = False
delete_confirmation = True
exit_done = False
remember_geometry = True
shred = False
units_iec = False
window_fullscreen = False
window_maximized = False
first_start = False
version = 4.4.2
window_x = 283
window_y = 48
window_width = 854
window_height = 600
hashsalt = 42b4eb38b392a52081267d5fd7617327bac02d073a4a04b78ad61cfc0c606a905017cd4b6b0fe95409e51cb492123384680fc0c77aef31331b638a5f0f46a30a

[hashpath]

[preserve_languages]
en = True
es = True

[tree]
apt = True
apt.autoclean = True
apt.autoremove = True
apt.clean = True
apt.package_lists = True
bash = True
bash.history = True
brave = True
brave.dom = True
brave.cache = True
brave.vacuum = True
brave.passwords = True
brave.history = True
brave.form_history = True
brave.search_engines = True
brave.site_preferences = True
brave.session = True
brave.sync = True
chromium = True
chromium.dom = True
chromium.cache = True
chromium.vacuum = True
chromium.cookies = True
chromium.history = True
chromium.form_history = True
chromium.search_engines = True
chromium.site_preferences = True
chromium.session = True
chromium.sync = True
deepscan = True
deepscan.ds_store = True
deepscan.backup = True
deepscan.vim_swap_user = True
deepscan.vim_swap_root = True
deepscan.tmp = True
deepscan.thumbs_db = True
firefox = True
firefox.dom = True
firefox.backup = True
firefox.cache = True
firefox.vacuum = True
firefox.cookies = True
firefox.forms = True
firefox.url_history = True
firefox.crash_reports = True
firefox.site_preferences = True
firefox.session_restore = True
journald = True
journald.clean = True
thumbnails = True
thumbnails.cache = True
system = True
system.desktop_entry = True
system.tmp = True
system.cache = True
system.custom = True
system.recent_documents = True
system.trash = True
system.clipboard = True
system.rotated_logs = True
vlc = True
vlc.mru = True
vlc.memory_dump = True
x11 = True
x11.debug_logs = True
" > /root/.config/bleachbit/bleachbit.ini



fi


