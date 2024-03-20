#!/bin/bash

echo '########################## APPS BASICAS #########################'
## Actualizacion repositorios
sudo apt update 

## BASE
sudo apt install nala                                                                 -y
sudo nala upgrade 																	  -y

sudo nala install xorg 																  -y

sudo nala install htop neofetch gparted tlp ufw 					                  -y



sudo nala install lm-sensors nano inxi bash-completion 	          					  -y

sudo nala install arandr gvfs p7zip-full  			     							  -y

sudo nala install xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs 			  -y

sudo nala install lightdm lightdm-gtk-greeter 										  -y






                                       
sudo nala install lxappearance arandr sakura thunar orage 						           -y


#                 Lanzador           Filtro          EditorTxt       Screenshot				
sudo nala install rofi               redshift        geany           gnome-screenshot      -y

#                 Calculadora        Portapapeles    Limpiador       VisorDocumentos
sudo nala install qalculate-gtk      parcellite      bleachbit       evince                -y



## OPCIONALES
sudo nala install   android-file-transfer  												   -y



## 

if [ "$isFlatpak" == "n" ] || [ "$isFlatpak" == "N" ]; then

	echo "##////////// Instalando apps de forma tradicional... //////////"
	
	wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
	
	#                  Navegador        Video             Musica                
	sudo nala install firefox-esr       mpv               audacious                                 -y      

	#                  Galeria          Editor Fotos	  Salvapantalla
	sudo nala install  mirage           gnome-paint       xscreensaver                              -y

fi



echo "################################ UFW ##############################" 
## Asegurar instalacion
sudo nala install ufw -y

## Permitir el trafico saliente
sudo ufw default allow outgoing

## Bloquear el trafico entrante
sudo ufw default deny incoming

## Permitir trafico ssh
#sudo ufw allow ssh

# Activacion ufw
sudo ufw enable 






echo "############################## THUNAR ################################" 
## Asegurar instalacion
sudo nala install thunar -y

## Establecer terminal por defecto
mkdir -p $HOME/.config/xfce4/

echo "TerminalEmulator=sakura" >> $HOME/.config/xfce4/helpers.rc






echo '################### CONFIGURACION DE LIBINPUT #####################'

if [ "$(sed -n '/Option "Tapping" "true"/p' /usr/share/X11/xorg.conf.d/40-libinput.conf)" == 'Option "Tapping" "true"' ]; then 

	echo "Perfecto!, existe la configracion, omitiendo este paso...";

else 

   echo "No existe la configuracion, aplicando...."
   sudo sed -i '/Identifier "libinput touchpad catchall"/a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf

   echo "Listo"
fi




echo '##################### CONFIGURACION DE POLKIT ######################'
## Asegurar instalacion
sudo nala install policykit-1-gnome -y






echo '########### GENERACION DE CARPETAS DE USUARIO BASICAS #############'
## Asegurar instalacion
sudo nala install xdg-user-dirs

## Configurando...
xdg-user-dirs-update 





echo '####################### AUDIO #########################'


# 1. INSTALACION DE LA BASE (ALSA)  
sudo nala install alsa-oss alsa-tools alsa-utils -y



if [ "$isPipeWire" == "y" ] || [ "$isPipeWire" == "" ]; then

	if [ $(command -v pulseaudio) &>/dev/null ]; then                      #### PENDIENTE DE COMPROBAR SI FUNCIONA
		## PulseAudio detectado. Desinstalando...
		systemctl --user --now disable pulseaudio.service pulseaudio.socket
	else 
		echo "No existe pulseaudio, continuando al siguiente paso..."
	fi

	## 2. SERVIDOR DE AUDIO
	### PIPEWIRE
	## // Paso 1.  Instalacion
	sudo nala install pipewire-audio wireplumber pipewire-pulse pipewire-alsa libspa-0.2-bluetooth pavucontrol -y

	## // Paso 2.  Configuracion
	systemctl --user --now enable pipewire pipewire-pulse  
	systemctl --user --now enable wireplumber.service

	else
	
	echo "## No se instalara PipeWire"
fi


## Configuracion volumen
amixer sset Master 99%




echo '########################### APARIENCIA ###########################'
mkdir -p $HOME/.config/gtk-3.0/

echo "[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=URW Gothic 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
" > $HOME/.config/gtk-3.0/settings.ini








echo '################### CONFIGURACION DE GRUB ########################'
### Contador a 1 segundo
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

### Guardar la ultima particion seleccionada
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
sudo sed -i '/GRUB_DEFAULT=saved/a GRUB_SAVEDEFAULT=true' /etc/default/grub

### Wallpaper grub
#### Copiar...
sudo cp system/imgGrub/* /boot/grub/imgGrub.jpg

#### Configurar 
sudo sed -i '$a GRUB_BACKGROUND="/boot/grub/imgGrub.jpg"' /etc/default/grub


## Actualizar cambios a grub
sudo update-grub

echo '######################### BLUETOOTH ##############################'


if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then

	echo "## Instalando paquetes para bluetooth..."

	###               Soporte basico para bluetooth       Interfaz grafica para la gestion
	sudo nala install bluez                               blueman
	
	### Iniciar y habilitar el servicio 
	sudo systemctl start bluetooth.service 
	sudo systemctl enable bluetooth.service 
	
else 
	 
	echo "## No se instalaran los paquetes para bluetooth"
	
fi




	echo '################ SUSPENSION POR INACTIVIDAD #####################' ######## ?????????? - PENDIENTE
	## Suspender despues de 30 minutos de inactividad
	# ?
	




# Comprobar si es una laptop o un PC de escritorio
if [ -e /sys/class/power_supply/BAT1 ] || [ -e /sys/class/power_supply/BAT0 ]; then

	echo "######## Bateria detectada ########"   
	echo "## Se instalan los paquetes 'brightnessctl' y 'acpi'"  
	sudo nala install brightnessctl acpi 											  -y
	

	echo '############### XSCREENSAVER PARA LAPTOP ####################'
		# Apagar y bloquear la pantalla después de 1 minuto de inactividad:
		## Asegurar instalacion
		sudo nala install xscreensaver
		## Configuracion 
		cp system/xScreenSaver/xSSLatop $HOME/.xscreensaver 

else
	
	echo "## Sin bateria detectada, se considera un PC de escritorio"     
	echo "## Se omiten los paquetes 'brightnessctl' y 'acpi'"
	
	echo '############### XSCREENSAVER PARA PC ####################'
		# Apagar y bloquear la pantalla después de 1 minuto de inactividad:
		## Asegurar instalacion
		sudo nala install xscreensaver
		## Configuracion 
		cp system/xScreenSaver/xSSPC $HOME/.xscreensaver 

fi

echo '######################## NETWORK MANAGER ##############################'

## Para NetworkManager
sudo nala install network-manager-gnome 											  -y

echo '## Deshabilitar "interfaces"'
sudo mv /etc/network/interfaces /etc/network/interfaces.old




############################# SCRIPTS ##################################
######### toggle nm-applet
mkdir -p $HOME/.config/scripts/

echo '
#!/bin/bash

if pgrep -x "nm-applet" > /dev/null
then
	pkill nm-applet
else
	nm-applet &
fi

' > $HOME/.config/scripts/toggle_nm-applet.sh

chmod +x $HOME/.config/scripts/toggle_nm-applet.sh



######### toogle orage (Calendario)
## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
echo '
#!/bin/bash

if pgrep -x "orage" > /dev/null
then
        pkill orage
else
        orage &
fi


' > $HOME/.config/scripts/toggle_orage.sh

chmod +x $HOME/.config/scripts/toggle_orage.sh


#~ echo '#### NOTIFICACION BATERIA #####'

#~ mkdir -p $HOME/.config/scripts

#~ echo '
	#~ #!/bin/bash
	
	
	#~ # Obtener el nivel de batería
	#~ battery_level=$(acpi -b | grep -P -o "[0-9]+(?=%)")

	#~ # Comprobar si el nivel de batería es bajo
	#~ if [ "$battery_level" -lt 101 ]; then
		#~ # Mostrar notificación
		#~ xmessage -center -buttons Aceptar:OK -default Aceptar -title "AVISO: Bateria baja" -bg \#FFAA00 -fg \#000000 -geometry 400x200 El nivel de la bateria es del $battery_level%. &
	#~ fi
		
	#~ ' > $HOME/.config/scripts/batteryCheck.sh

#~ chmod +x $HOME/.config/scripts/batteryCheck.sh

#~ sudo sed -i '$a */2 *  *  *  *   '"$USER"'   '"$HOME"'/.config/scripts/batteryCheck.sh' /etc/crontab
