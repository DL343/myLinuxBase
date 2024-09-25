#!/bin/bash

install=" apt install"

y="-y"






echo "
########################################################################
	                 ACTUALIZANDO REPOSITORIOS
########################################################################
"

 apt update




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
		##neofetch 
		gparted 
		btrfs-progs ## Herramientas para manejar el sistema de archivos Btrfs.
		mtools ## Conjunto de herramientas para manipular disquetes (especialmente FAT).
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
		
	)


	for package in "${myAppsMinimal[@]}"
	do
		echo "
		-------------------------------------------
		Instalando $package...
		-------------------------------------------
		"
		$install $package $y

	done
	
}

function myApps(){
	
	



myApps=(

	##preload  
	##cryptsetup ## Herramienta para gestionar el cifrado de discos y particiones usando LUKS.
	gcr ## Biblioteca para manejar certificados y claves, usada en aplicaciones de seguridad.
	##unar ## Utilidad para descomprimir archivos en varios formatos, como RAR y ZIP.
	keyutils ## Utilidades para gestionar claves y conjuntos de claves en el kernel de Linux.
	ncdu
	p7zip-full
	inxi  
	xdg-user-dirs		  										  
	lxappearance 
	lxrandr 
	



	## Usuario
	parcellite 
	rofi  
	flameshot
	mirage
	nitrogen
	redshift
	numlockx
	volumeicon-alsa
       
	bleachbit      					 
            
	mpv               
	audacious      
	console-data                         
	#xscreensaver 
	#evince  




	## Personalizacion
	#yaru-theme-gtk 
	#yaru-theme-icon 

)

	for package in "${myApps[@]}"
	do
		echo "
		-------------------------------------------
		Instalando $package...
		-------------------------------------------
		"
		$install $package $y

	done


	echo "## Brave" 
	$install curl -y
	 curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list
	 apt update
	$install brave-browser -y
	
	
	
	


echo '
######################################################################## 
                               PRELOAD
########################################################################
'

## systemctl enable preload.service


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
    sed -i '/Identifier "libinput touchpad catchall"/a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf

   echo "Listo"
fi






#echo '
#########################################################################
                    #PROTECTOR DE PANTALLA
#########################################################################
#'

## Comprobar si es una laptop o un PC de escritorio
#if [ -e /sys/class/power_supply/BAT1 ] || [ -e /sys/class/power_supply/BAT0 ]; then

	#echo "######## Bateria detectada ########"   
	#echo "## Se instalan los paquetes 'brightnessctl' y 'acpi'"  
	# apt -y install brightnessctl acpi 											 
	

	#echo '############### XSCREENSAVER PARA LAPTOP ####################'
		## Apagar y bloquear la pantalla después de 1 minuto de inactividad:
		### Asegurar instalacion
		# apt -y install xscreensaver 
		### Configuracion 
		#cp system/xScreenSaver/xSSLatop $HOME/.xscreensaver 

#else
	
	#echo "## Sin bateria detectada, se considera un PC de escritorio"     
	#echo "## Se omiten los paquetes 'brightnessctl' y 'acpi'"
	
	#echo '############### XSCREENSAVER PARA PC ####################'
		## Apagar y bloquear la pantalla después de 1 minuto de inactividad:
		### Asegurar instalacion
		# apt -y install xscreensaver
		### Configuracion 
		#cp system/xScreenSaver/xSSPC $HOME/.xscreensaver 

#fi



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
 apt upgrade -y






echo "
########################################################################
                               UFW
########################################################################
" 


## Permitir el trafico saliente
 ufw default allow outgoing

## Bloquear el trafico entrante
 ufw default deny incoming

## Permitir trafico ssh
# ufw allow ssh

# Activacion ufw
 ufw enable 






#echo "############################## PCMANFM ################################" 



### Establecer terminal por defecto
#mkdir -p $HOME/.config/xfce4/

#echo "TerminalEmulator=sakura" >> $HOME/.config/xfce4/helpers.rc




echo '
########################################################################
                           AUDIO
########################################################################
'

# 1. INSTALACION DE LA BASE (ALSA)  
	
: '
#appsAlsa=(
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
'



if which pipewire
then
	echo "::::: Existe PIPEWIRE, omitiendo esta seccion"
else


	if [ "$isPipeWire" == "y" ] || [ "$isPipeWire" == "" ]
	then


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
		
		for package in "${appsPipewire[@]}"
		do
			echo "
			-------------------------------------------
			Instalando $package...
			-------------------------------------------
			"
			$install $package $y
		done
		

		## // Paso 2.  Configuracion
		systemctl --user --now enable pipewire pipewire-pulse  
		systemctl --user --now enable wireplumber.service

	else
		
		echo "## No se instalara PipeWire"
	
	fi

fi









echo '
########################################################################
                      CONFIGURACION DE GRUB
########################################################################'
### Contador a 1 segundo
 sed -i '/GRUB_TIMEOUT=/c GRUB_TIMEOUT=1' /etc/default/grub

### Guardar la ultima particion seleccionada
 sed -i '/GRUB_DEFAULT=/c GRUB_DEFAULT=saved/g' /etc/default/grub

if grep -q "GRUB_SAVEDEFAULT=true" /etc/default/grub
then

	echo "Existe 'GRUB_SAVEDEFAULT=true' omitiendo este paso"

else

	 sed -i '/GRUB_DEFAULT=saved/a GRUB_SAVEDEFAULT=true' /etc/default/grub

fi

### Wallpaper grub
#### Copiar...
 cp ./Apps/grub/* /boot/grub/imgGrub.jpg
#### Añade al final
 sed -i '$a GRUB_BACKGROUND="/boot/grub/imgGrub.jpg"' /etc/default/grub

#### Mostrar informacion mas detallada
 sed -i '/GRUB_DISTRIBUTOR=/c GRUB_DISTRIBUTOR=`lsb_release -d -s 2> \/dev\/null || echo Debian`' /etc/default/grub

 sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/c GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' /etc/default/grub


## Actualizar cambios a grub
 update-grub




echo '
########################################################################
                             BLUETOOTH
########################################################################
'


if [ "$isBluetooth" == "y" ] || [ "$isBluetooth" == "" ]; then

	echo "::::: Instalando paquetes para bluetooth..."

	###               Soporte basico para bluetooth       Interfaz grafica para la gestion
	 apt install  bluez                               blueman -y
	
	### Iniciar y habilitar el servicio 
	 systemctl start bluetooth.service 
	 systemctl enable bluetooth.service 
	
else 
	 
	echo "::::: No se instalaran los paquetes para bluetooth"
	
fi





echo '
########################################################################
                         NETWORK MANAGER
########################################################################
'

echo '::::: Deshabilitando "interfaces"...'
 mv /etc/network/interfaces /etc/network/interfaces.old







echo "
########################################################################
                              SWAPPINESS
########################################################################
"
## Ajuste swappines 
if grep -q 'vm.swappiness=' /etc/sysctl.conf
then
	echo "::::: Texto encontrado, ajustando..."
	 sed -i '/vm.swappiness=/c vm.swappiness=15' /etc/sysctl.conf

else
	echo "::::: Texto no encontrado, añadiendo..."
	echo "vm.swappiness=15" |  tee -a /etc/sysctl.conf > /dev/null
	
fi










echo "
########################################################################
                            LIGHTDM
########################################################################
"


echo '###### HABILITAR EL DM ######'
if [ "$isInit" ==  "systemd" ]; then
	 systemctl enable lightdm.service
elif [ "$isInit" ==  "init" ]; then
	 update-rc.d -f lightdm defaults
fi

echo '###### PERSONALIZACION ######' 

## Configuracion de greeter
 sed -i '/# greeter-session=lightdm-gtk-greeter-settings/cgreeter-session=lightdm-gtk-greeter-settings' /etc/lightdm/lightdm.conf 

## Copiado de wallpaper aleatorio
carpeta="./wallpapers"
if [ ! -d "$carpeta" ] 
then

    echo "El directorio no existe"
    
fi


imagenes=( "$carpeta"/*.{jpg,png} )
if [ ${#imagenes[@]} -eq 0 ]
then

	echo "No hay imagenes"
	
fi

## Seleccion de indice aleatorio
indice=$(( RANDOM % ${#imagenes[@]} ))
imagenSeleccionada="${imagenes[$indice]}"

 cp "$imagenSeleccionada" /usr/share/pixmaps/lightdm.jpg

## Configuracion del wallpaper
echo '[greeter]
background = /usr/share/pixmaps/lightdm.jpg
theme-name = Adwaita-dark
icon-theme-name = Adwaita

' |  tee /etc/lightdm/lightdm-gtk-greeter.conf



## Desactivar la ocultacion de los usuarios disponibles
 sed -i '/greeter-hide-users=/c greeter-hide-users=false' /usr/share/lightdm/lightdm.conf.d/01_debian.conf 





echo "
########################################################################
                               TLP
########################################################################
"
function TlpPowerSave(){

if [ "$isPowerSave" == "y" ] || [ "$isPowerSave" == "Y" ] ||  [ "$isPowerSave" == "" ]
then

	echo "## Configurando modo ahorro de energia..."
	
     cp ./Apps/tlp/powerSaveTLP /etc/tlp.conf 

	echo "## Modo ahorro de energia aplicando correctamente!"
		
else 

	echo "## TLP se instalara con la configuracion predeterminada"	
	
fi

}


if [ "$isTlp" == "y" ] || [ "$isTlp" == "Y" ] ||  [ "$isTlp" == "" ]
then

	echo "## Instalacion de TLP..."

	 apt install tlp -y
	
	echo "## Habilitando servicio..."
	 systemctl enable tlp
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
	
	## Asegurar instalacion
	install cpufrequtils  

	## Creacion del directorio por si no existe
	mkdir -p ~/.config/scripts/

	## Configuracion e inyeccion del script
	echo '#!/bin/bash

	 cpufreq-set -c  0 -u 1.8GHz
	 cpufreq-set -c  5 -u 1.8GHz
	 cpufreq-set -c  7 -u 1.8GHz

	 cpufreq-set -c  0 -g ondemand
	 cpufreq-set -c  5 -g ondemand
	 cpufreq-set -c  7 -g ondemand

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


	' |  tee /etc/systemd/system/low_power.service



	## Habilitando el servicio en systemd
	 systemctl enable low_power.service


	: " POWER SUPER SAVE

	 cpufreq-set -c  0 -u 1.2GHz
	 cpufreq-set -c  5 -u 1.2GHz
	 cpufreq-set -c  7 -u 1.2GHz

	 cpufreq-set -c  0 -u 1.4GHz
	 cpufreq-set -c  5 -u 1.4GHz
	 cpufreq-set -c  7 -u 1.4GHz

	 cpufreq-set -c  0 -u 1.8GHz
	 cpufreq-set -c  5 -u 1.8GHz
	 cpufreq-set -c  7 -u 1.8GHz

	 cpufreq-set -c  0 -g ondemand
	 cpufreq-set -c  5 -g ondemand
	 cpufreq-set -c  7 -g ondemand


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

#~  sed -i '$a */2 *  *  *  *   '"$USER"'   '"$HOME"'/.config/scripts/batteryCheck.sh' /etc/crontab






