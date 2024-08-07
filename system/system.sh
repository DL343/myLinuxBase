#!/bin/bash

install="sudo apt install"

y="-y"






echo "
########################################################################
	                 ACTUALIZANDO REPOSITORIOS
########################################################################
"

sudo apt update




echo "
########################################################################
                                APPS 
########################################################################
"




function appsMinimal(){
	echo "
	-------------
	   Minimas
	-------------
	"
	myAppsMinimal=(
	## Base
		xorg
		bash-completion 
		htop 
		btop
		neofetch 
		gparted 
		geany
		pcmanfm
		sakura
		network-manager-gnome
		nano 
		gvfs
		xarchiver
		policykit-1-gnome
		ufw 	
		lightdm
		lightdm-gtk-greeter	
		cpufrequtils  
	)


	for package in "${myAppsMinimal[@]}"
	do

		union="$install $package $y"
		echo "
		-------------------------------------------
		Instalando $package...
		-------------------------------------------
		"
		
		$union

	done
	
}

function myApps(){
	
	



myApps=(

	preload  

	p7zip-full
	lm-sensors 
	orage
	inxi 
	arandr 
	xdg-user-dirs		  										  
	lxappearance 
	arandr 



	## Usuario
	parcellite 
	rofi  
	gnome-screenshot 
	mirage

	grimshot
	
	qalculate-gtk          
	bleachbit      					 
	evince            
	firefox-esr      
	mpv               
	audacious                           
	gnome-paint       
	xscreensaver 





	## Personalizacion
	yaru-theme-gtk 
	yaru-theme-icon 
	nitrogen
	redshift

)




	for package in "${myApps[@]}"
	do

		union="$install $package $y"
		echo "
		-------------------------------------------
		Instalando $package...
		-------------------------------------------
		"
		
		$union

	done


	echo "## Brave" 
	$install curl -y
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	$install brave-browser -y
	
	
	
	
	


echo '
######################################################################## 
                               PRELOAD
########################################################################
'

sudo systemctl enable preload.service


echo '
######################################################################## 
            GENERACION DE CARPETAS DE USUARIO BASICAS
########################################################################
'


## Configuracion
xdg-user-dirs-update 



echo '
########################################################################
                     CONFIGURACION DE LIBINPUT 
########################################################################
 '

if [ "$(sed -n '/Option "Tapping" "true"/p' /usr/share/X11/xorg.conf.d/40-libinput.conf)" == 'Option "Tapping" "true"' ]; then 

	echo "Perfecto!, existe la configracion, omitiendo este paso...";

else 

   echo "No existe la configuracion, aplicando...."
   sudo sed -i '/Identifier "libinput touchpad catchall"/a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf

   echo "Listo"
fi






echo '
########################################################################
                    PROTECTOR DE PANTALLA
########################################################################
'

# Comprobar si es una laptop o un PC de escritorio
if [ -e /sys/class/power_supply/BAT1 ] || [ -e /sys/class/power_supply/BAT0 ]; then

	echo "######## Bateria detectada ########"   
	echo "## Se instalan los paquetes 'brightnessctl' y 'acpi'"  
	sudo apt install brightnessctl acpi 											  -y
	

	echo '############### XSCREENSAVER PARA LAPTOP ####################'
		# Apagar y bloquear la pantalla después de 1 minuto de inactividad:
		## Asegurar instalacion
		sudo apt install xscreensaver
		## Configuracion 
		cp system/xScreenSaver/xSSLatop $HOME/.xscreensaver 

else
	
	echo "## Sin bateria detectada, se considera un PC de escritorio"     
	echo "## Se omiten los paquetes 'brightnessctl' y 'acpi'"
	
	echo '############### XSCREENSAVER PARA PC ####################'
		# Apagar y bloquear la pantalla después de 1 minuto de inactividad:
		## Asegurar instalacion
		sudo apt install xscreensaver
		## Configuracion 
		cp system/xScreenSaver/xSSPC $HOME/.xscreensaver 

fi



}



if [ "$isMinimal" == "y" ] || [ "$isMinimal" == "Y" ] || [ "$isMinimal" == "" ]
then		

	appsMinimal

else

	appsMinimal
	myApps
	
fi

























echo "
########################################################################
               GENERANDO ACTUALILACION DEL SISTEMA
########################################################################
"
sudo apt upgrade -y






echo "
########################################################################
                               UFW
########################################################################
" 


## Permitir el trafico saliente
sudo ufw default allow outgoing

## Bloquear el trafico entrante
sudo ufw default deny incoming

## Permitir trafico ssh
#sudo ufw allow ssh

# Activacion ufw
sudo ufw enable 






#echo "############################## THUNAR ################################" 
### Asegurar instalacion
#sudo apt install thunar -y

### Establecer terminal por defecto
#mkdir -p $HOME/.config/xfce4/

#echo "TerminalEmulator=sakura" >> $HOME/.config/xfce4/helpers.rc




















echo '
########################################################################
                           AUDIO
########################################################################
'

# 1. INSTALACION DE LA BASE (ALSA)  
	
	
appsAlsa=(
	alsa-oss 
	alsa-tools 
	alsa-utils 
)



for package in "${appsAlsa[@]}";
do

	union="$install $package $y"
	echo "
	-------------------------------------------
	Instalando $package...
	-------------------------------------------
	"
	
	$union
	
done


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

	appsPipewire=(
		pipewire-audio
		wireplumber 
		pipewire-pulse 
		pipewire-alsa 
		libspa-0.2-bluetooth 
		pavucontrol 
	)
	
	for package in "${appsPipewire[@]}";
	do

		union="$install $package $y"
		echo "
		-------------------------------------------
		Instalando $package...
		-------------------------------------------
		"
		
		$union
	
	done
	

	## // Paso 2.  Configuracion
	systemctl --user --now enable pipewire pipewire-pulse  
	systemctl --user --now enable wireplumber.service

	else
	
	echo "## No se instalara PipeWire"
fi


## Configuracion volumen
amixer sset Master 100%








echo '
########################################################################
                      CONFIGURACION DE GRUB
########################################################################'
### Contador a 1 segundo
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

### Guardar la ultima particion seleccionada
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
sudo sed -i '/GRUB_DEFAULT=saved/a GRUB_SAVEDEFAULT=true' /etc/default/grub

### Wallpaper grub
#### Copiar...
sudo cp ./Apps/grub/* /boot/grub/imgGrub.jpg

#### Configurar 
sudo sed -i '$a GRUB_BACKGROUND="/boot/grub/imgGrub.jpg"' /etc/default/grub


## Actualizar cambios a grub
sudo update-grub




echo '
########################################################################
                             BLUETOOTH
########################################################################
'


if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then

	echo "## Instalando paquetes para bluetooth..."

	###               Soporte basico para bluetooth       Interfaz grafica para la gestion
	sudo apt install  bluez                               blueman -y
	
	### Iniciar y habilitar el servicio 
	sudo systemctl start bluetooth.service 
	sudo systemctl enable bluetooth.service 
	
else 
	 
	echo "## No se instalaran los paquetes para bluetooth"
	
fi





echo '
########################################################################
                         NETWORK MANAGER
########################################################################
'

echo '## Deshabilitar "interfaces"'
sudo mv /etc/network/interfaces /etc/network/interfaces.old







echo "
########################################################################
                              SWAPPINESS
########################################################################
"
## Swappines a 0
 sudo sed -i '/vm.swappiness=100/cvm.swappiness=0' /etc/sysctl.conf 



echo "
########################################################################
                               TECLADO
########################################################################
"
## En terminal 
##echo "KEYMAP=es" | sudo tee /etc/vconsole.conf
##echo "LANG=es_ES.UTF8" | sudo tee /etc/locale.conf

## En xorg
##sudo localectl set-x11-keymap latam









############################# SCRIPTS ##################################

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




echo "
########################################################################
                            LIGHTDM
########################################################################
"


echo '###### HABILITAR EL DM ######'
if [ "$isInit" ==  "systemd" ]; then
	sudo systemctl enable lightdm.service
elif [ "$isInit" ==  "init" ]; then
	sudo update-rc.d -f lightdm defaults
fi

echo '###### PERSONALIZACION ######' 

## Dar de alta greeter
sudo sed -i '/# greeter-session=lightdm-gtk-greeter-settings/cgreeter-session=lightdm-gtk-greeter-settings' /etc/lightdm/lightdm.conf 

## Copiado de wallpaper
sudo cp ./Apps/lightdm/* /usr/share/pixmaps/lightdm.jpg

## Configuracion del wallpaper
echo '[greeter]
background = /usr/share/pixmaps/lightdm.jpg
theme-name = Adwaita-dark
icon-theme-name = Adwaita

' | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf



## Desactivar la ocultacion de los usuarios disponibles
sudo sed -i 's/greeter-hide-users=true/greeter-hide-users=false/g' /usr/share/lightdm/lightdm.conf.d/01_debian.conf 




echo "
########################################################################
                               TLP
########################################################################
"
function TlpPowerSave(){

if [ "$isPowerSave" == "y" ] || [ "$isPowerSave" == "Y" ] ||  [ "$isPowerSave" == "" ]
then

	echo "## Configurando modo ahorro de energia..."
	
    sudo cp ./Apps/tlp/powerSaveTLP /etc/tlp.conf 

	echo "## Modo ahorro de energia aplicando correctamente!"
		
else 

	echo "## TLP se instalara con la configuracion predeterminada"	
	
fi

}


if [ "$isTlp" == "y" ] || [ "$isTlp" == "Y" ] ||  [ "$isTlp" == "" ]
then

	echo "## Instalacion de TLP..."

	sudo apt install tlp -y
	
	echo "## Habilitando servicio..."
	sudo systemctl enable tlp
	TlpPowerSave

else
 
	echo "TLP marcado para no instalar..."

fi















function lowPowerPrefix(){

	echo "
	########################################################################
						LOW POWER PREFIX - 5V 3A (15W)
	########################################################################
	"

	## Creacion del directorio por si no existe
	mkdir -p ~/.config/scripts/

	## Configuracion e inyeccion del script
	echo '#!/bin/bash

	sudo cpufreq-set -c  0 -u 1.8GHz
	sudo cpufreq-set -c  5 -u 1.8GHz
	sudo cpufreq-set -c  7 -u 1.8GHz

	sudo cpufreq-set -c  0 -g ondemand
	sudo cpufreq-set -c  5 -g ondemand
	sudo cpufreq-set -c  7 -g ondemand

	' > ~/.config/scripts/low_power.sh


	## Dando permiso de ejecucion al script
	chmod +x ~/.config/scripts/low_power.sh


	home=$HOME

	## Configuracion del servicio en systemd para ejecutar el script al arranque
	echo '                                                                                           
	## Se indican las directivas
	[Unit]
	## Descripcion del servicio
	Description=Servicio de una sola ejecucion para reducir el consumo para cargadores limitados a 5V 3A (15W)

	## Controla el orden de ejecucion, "ejecutate despues de ..."
	After=network.target network-online.target


	## Version ligera de "Requires". Systemd intentara arrancar las
	##  unidades indicadas
	Wants=network-online.target


	[Service]
	## Ruta del fichero/script a ejecutar               <-------------------------------------------------------------- INVESTIGAR COMO OBTENER RUTA DEL USUARIO ACTUAL
	ExecStart='$home'/.config/scripts/low_power.sh 


	[Install]
	WantedBy=multi-user.target


	' | sudo tee /etc/systemd/system/low_power.service



	## Habilitando el servicio en systemd
	sudo systemctl enable low_power.service


	: " POWER SUPER SAVE

	sudo cpufreq-set -c  0 -u 1.2GHz
	sudo cpufreq-set -c  5 -u 1.2GHz
	sudo cpufreq-set -c  7 -u 1.2GHz

	sudo cpufreq-set -c  0 -u 1.4GHz
	sudo cpufreq-set -c  5 -u 1.4GHz
	sudo cpufreq-set -c  7 -u 1.4GHz

	sudo cpufreq-set -c  0 -u 1.8GHz
	sudo cpufreq-set -c  5 -u 1.8GHz
	sudo cpufreq-set -c  7 -u 1.8GHz

	sudo cpufreq-set -c  0 -g ondemand
	sudo cpufreq-set -c  5 -g ondemand
	sudo cpufreq-set -c  7 -g ondemand


	1.8Ghz = max 11.6 W 
	1.2Ghz = max 7.6 W

	"

}

function alacritty(){



	echo "
	########################################################################
									ALACRITTY
	########################################################################
	"



	## Creacion de la carpeta 
	mkdir -p $HOME/.config/alacritty/

	## Creacion del archivo
	touch $HOME/.config/alacritty/alacritty.toml


	echo "
	-----------------------
		Personalizacion 
	-----------------------
	" 

	echo '
	import = [
		"~/.config/alacritty/themes/themes/breeze.toml"
	]
	' > $HOME/.config/alacritty/alacritty.toml


	# We use Alacritty's default Linux config directory as our storage location here.
	mkdir -p ~/.config/alacritty/themes
	git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes


}




