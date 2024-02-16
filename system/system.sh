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

sudo nala install arandr gvfs 	p7zip-full 			     							  -y

sudo nala install xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs 			  -y

sudo nala install lightdm lightdm-gtk-greeter 										  -y



## Para NetworkManager
sudo nala install network-manager-gnome 											  -y


                                       
sudo nala install lxappearance arandr sakura thunar 								  -y


#                 Lanzador           Filtro          EditorTxt       Screenshot				
sudo nala install rofi               redshift        geany           gnome-screenshot      -y

#                 Calculadora        Portapapeles    Limpiador       VisorDocumentos
sudo nala install qalculate-gtk      parcellite      bleachbit       evince                -y

#                                  
# sudo nala install           															   -y



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
sudo nala install ufw

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
sudo nala install thunar

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

if [ "$isPolkit" == "y" ] || [ "$isPolkit" == "" ]; then

	## Asegurar instalacion
	sudo nala install policykit-1-gnome

	## Configurando...
	echo "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &" >> $HOME/.icewm/startup  


fi


echo '########### GENERACION DE CARPETAS DE USUARIO BASICAS #############'
## Asegurar instalacion
sudo nala install xdg-user-dirs

## Configurando...
xdg-user-dirs-update 





echo '####################### AUDIO #########################'


# 1. INSTALACION DE LA BASE (ALSA)  
sudo nala install alsa-oss alsa-tools alsa-utils -y



if [ "$isPipeWire" == "y" ] || [ "$isPipeWire" == "" ]; then

	if [ command -v pulseaudio &>/dev/null ]; then                      #### PENDIENTE DE COMPROBAR SI FUNCIONA
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




	echo '################ SUSPENSION POR INACTIVIDAD #####################'
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
	function confXSSL() {

	echo '# XScreenSaver Preferences File
	# Written by xscreensaver-settings 6.06 
	# https://www.jwz.org/xscreensaver/

	timeout:	0:01:00
	cycle:		0:00:00
	lock:		True
	lockTimeout:	0:00:00
	passwdTimeout:	0:00:30
	visualID:	default
	installColormap:    True
	verbose:	False
	splash:		True
	splashDuration:	0:00:05
	demoCommand:	xscreensaver-settings
	nice:		10
	fade:		False
	unfade:		False
	fadeSeconds:	0:00:03
	ignoreUninstalledPrograms:False
	dpmsEnabled:	True
	dpmsQuickOff:	True
	dpmsStandby:	0:00:00
	dpmsSuspend:	0:00:00
	dpmsOff:	0:00:00
	grabDesktopImages:  False
	grabVideoFrames:    False
	chooseRandomImages: False
	imageDirectory:	

	mode:		blank
	selected:	155

	textMode:	url
	textLiteral:	XScreenSaver
	textFile:	
	textProgram:	fortune
	textURL:	https://planet.debian.org/rss20.xml
	dialogTheme:	default
	settingsGeom:	12,27 -1,-1

	programs:								      \
					maze --root				    \n\
	- GL: 				superquadrics --root			    \n\
					attraction --root			    \n\
					blitspin --root				    \n\
					greynetic --root			    \n\
					helix --root				    \n\
					hopalong --root				    \n\
					imsmap --root				    \n\
	-				noseguy --root				    \n\
	-				pyro --root				    \n\
					qix --root				    \n\
	-				rocks --root				    \n\
					rorschach --root			    \n\
					decayscreen --root			    \n\
					flame --root				    \n\
					halo --root				    \n\
					slidescreen --root			    \n\
					pedal --root				    \n\
					bouboule --root				    \n\
	-				braid --root				    \n\
					coral --root				    \n\
					deco --root				    \n\
					drift --root				    \n\
	-				fadeplot --root				    \n\
					galaxy --root				    \n\
					goop --root				    \n\
					grav --root				    \n\
					ifs --root				    \n\
					unicode --root				    \n\
	- GL: 				jigsaw --root				    \n\
					julia --root				    \n\
	-				kaleidescope --root			    \n\
	- GL: 				moebius --root				    \n\
					moire --root				    \n\
	- GL: 				morph3d --root				    \n\
					mountain --root				    \n\
					munch --root				    \n\
					penrose --root				    \n\
	- GL: 				pipes --root				    \n\
					rdbomb --root				    \n\
	- GL: 				rubik --root				    \n\
	-				sierpinski --root			    \n\
					slip --root				    \n\
	- GL: 				sproingies --root			    \n\
					starfish --root				    \n\
					strange --root				    \n\
					swirl --root				    \n\
					triangle --root				    \n\
					xjack --root				    \n\
					xlyap --root				    \n\
	- GL: 				atlantis --root				    \n\
					bsod --root				    \n\
	- GL: 				bubble3d --root				    \n\
	- GL: 				cage --root				    \n\
	-				crystal --root				    \n\
					cynosure --root				    \n\
					discrete --root				    \n\
					distort --root				    \n\
					epicycle --root				    \n\
					flow --root				    \n\
	- GL: 				glplanet --root				    \n\
					interference --root			    \n\
					kumppa --root				    \n\
	- GL: 				lament --root				    \n\
					moire2 --root				    \n\
	- GL: 				sonar --root				    \n\
	- GL: 				stairs --root				    \n\
					truchet --root				    \n\
	-				vidwhacker --root			    \n\
	-				webcollage --root			    \n\
					blaster --root				    \n\
					bumps --root				    \n\
					ccurve --root				    \n\
					compass --root				    \n\
					deluxe --root				    \n\
	-				demon --root				    \n\
	- GL: 				extrusion --root			    \n\
	-				loop --root				    \n\
					penetrate --root			    \n\
					petri --root				    \n\
					phosphor --root				    \n\
	- GL: 				pulsar --root				    \n\
					ripples --root				    \n\
					shadebobs --root			    \n\
	- GL: 				sierpinski3d --root			    \n\
					spotlight --root			    \n\
					squiral --root				    \n\
					wander --root				    \n\
					xflame --root				    \n\
					xmatrix --root				    \n\
	- GL: 				gflux --root				    \n\
	-				nerverot --root				    \n\
					xrayswarm --root			    \n\
					xspirograph --root			    \n\
	- GL: 				circuit --root				    \n\
	- GL: 				dangerball --root			    \n\
	- GL: 				dnalogo --root				    \n\
	- GL: 				engine --root				    \n\
	- GL: 				flipscreen3d --root			    \n\
	- GL: 				gltext --root				    \n\
	- GL: 				menger --root				    \n\
	- GL: 				molecule --root				    \n\
					rotzoomer --root			    \n\
					scooter --root				    \n\
					speedmine --root			    \n\
	- GL: 				starwars --root				    \n\
	- GL: 				stonerview --root			    \n\
					vermiculate --root			    \n\
					whirlwindwarp --root			    \n\
					zoom --root				    \n\
					anemone --root				    \n\
					apollonian --root			    \n\
	- GL: 				boxed --root				    \n\
	- GL: 				cubenetic --root			    \n\
	- GL: 				endgame --root				    \n\
					euler2d --root				    \n\
					fluidballs --root			    \n\
	- GL: 				flurry --root				    \n\
	- GL: 				glblur --root				    \n\
	- GL: 				glsnake --root				    \n\
					halftone --root				    \n\
	- GL: 				juggler3d --root			    \n\
	- GL: 				lavalite --root				    \n\
	-				polyominoes --root			    \n\
	- GL: 				queens --root				    \n\
	- GL: 				sballs --root				    \n\
	- GL: 				spheremonics --root			    \n\
					twang --root				    \n\
	- GL: 				antspotlight --root			    \n\
					apple2 --root				    \n\
	- GL: 				atunnel --root				    \n\
					barcode --root				    \n\
	- GL: 				blinkbox --root				    \n\
	- GL: 				blocktube --root			    \n\
	- GL: 				bouncingcow --root			    \n\
					cloudlife --root			    \n\
	- GL: 				cubestorm --root			    \n\
					eruption --root				    \n\
	- GL: 				flipflop --root				    \n\
	- GL: 				flyingtoasters --root			    \n\
					fontglide --root			    \n\
	- GL: 				gleidescope --root			    \n\
	- GL: 				glknots --root				    \n\
	- GL: 				glmatrix --root				    \n\
	- GL: 				glslideshow --root			    \n\
	- GL: 				hypertorus --root			    \n\
	- GL: 				jigglypuff --root			    \n\
					metaballs --root			    \n\
	- GL: 				mirrorblob --root			    \n\
					piecewise --root			    \n\
	- GL: 				polytopes --root			    \n\
					pong --root				    \n\
					popsquares --root			    \n\
	- GL: 				surfaces --root				    \n\
					xanalogtv --root			    \n\
					abstractile --root			    \n\
					anemotaxis --root			    \n\
	- GL: 				antinspect --root			    \n\
					fireworkx --root			    \n\
					fuzzyflakes --root			    \n\
					interaggregate --root			    \n\
					intermomentary --root			    \n\
					memscroller --root			    \n\
	- GL: 				noof --root				    \n\
					pacman --root				    \n\
	- GL: 				pinion --root				    \n\
	- GL: 				polyhedra --root			    \n\
	- GL: 				providence --root			    \n\
					substrate --root			    \n\
					wormhole --root				    \n\
	- GL: 				antmaze --root				    \n\
	- GL: 				boing --root				    \n\
					boxfit --root				    \n\
	- GL: 				carousel --root				    \n\
					celtic --root				    \n\
	- GL: 				crackberg --root			    \n\
	- GL: 				cube21 --root				    \n\
					fiberlamp --root			    \n\
	- GL: 				fliptext --root				    \n\
	- GL: 				glhanoi --root				    \n\
	- GL: 				tangram --root				    \n\
	- GL: 				timetunnel --root			    \n\
	- GL: 				glschool --root				    \n\
	- GL: 				topblock --root				    \n\
	- GL: 				cubicgrid --root			    \n\
					cwaves --root				    \n\
	- GL: 				gears --root				    \n\
	- GL: 				glcells --root				    \n\
	- GL: 				lockward --root				    \n\
					m6502 --root				    \n\
	- GL: 				moebiusgears --root			    \n\
	- GL: 				voronoi --root				    \n\
	- GL: 				hypnowheel --root			    \n\
	- GL: 				klein --root				    \n\
	-				lcdscrub --root				    \n\
	- GL: 				photopile --root			    \n\
	- GL: 				skytentacles --root			    \n\
	- GL: 				rubikblocks --root			    \n\
	- GL: 				companioncube --root			    \n\
	- GL: 				hilbert --root				    \n\
	- GL: 				tronbit --root				    \n\
	- GL: 				geodesic --root				    \n\
					hexadrop --root				    \n\
	- GL: 				kaleidocycle --root			    \n\
	- GL: 				quasicrystal --root			    \n\
	- GL: 				unknownpleasures --root			    \n\
					binaryring --root			    \n\
	- GL: 				cityflow --root				    \n\
	- GL: 				geodesicgears --root			    \n\
	- GL: 				projectiveplane --root			    \n\
	- GL: 				romanboy --root				    \n\
					tessellimage --root			    \n\
	- GL: 				winduprobot --root			    \n\
	- GL: 				splitflap --root			    \n\
	- GL: 				cubestack --root			    \n\
	- GL: 				cubetwist --root			    \n\
	- GL: 				discoball --root			    \n\
	- GL: 				dymaxionmap --root			    \n\
	- GL: 				energystream --root			    \n\
	- GL: 				hexstrut --root				    \n\
	- GL: 				hydrostat --root			    \n\
	- GL: 				raverhoop --root			    \n\
	- GL: 				splodesic --root			    \n\
	- GL: 				unicrud --root				    \n\
	- GL: 				esper --root				    \n\
	- GL: 				vigilance --root			    \n\
	- GL: 				crumbler --root				    \n\
					filmleader --root			    \n\
					glitchpeg --root			    \n\
	- GL: 				handsy --root				    \n\
	- GL: 				maze3d --root				    \n\
	- GL: 				peepers --root				    \n\
	- GL: 				razzledazzle --root			    \n\
					vfeedback --root			    \n\
	- GL: 				deepstars --root			    \n\
	- GL: 				gravitywell --root			    \n\
	- GL: 				beats --root				    \n\
	- GL: 				covid19 --root				    \n\
	- GL: 				etruscanvenus --root			    \n\
	- GL: 				gibson --root				    \n\
	- GL: 				headroom --root				    \n\
	- GL: 				sphereeversion --root			    \n\
					binaryhorizon --root			    \n\
					marbling --root				    \n\
	- GL: 				chompytower --root			    \n\
	- GL: 				hextrail --root				    \n\
	- GL: 				mapscroller --root			    \n\
	- GL: 				nakagin --root				    \n\
	- GL: 				squirtorus --root			    \n\


	pointerHysteresis:  10
	authWarningSlack:   20

	' >> $HOME/.xscreensaver

	}
	confXSSL

	else
	
	echo "## Sin bateria detectada, se considera un PC de escritorio"     
	echo "## Se omiten los paquetes 'brightnessctl' y 'acpi'"
	
		echo '############### XSCREENSAVER PARA PC ####################'
	# Apagar y bloquear la pantalla después de 1 minuto de inactividad:
	## Asegurar instalacion
	sudo nala install xscreensaver
	## Configuracion 
	function confXSSPC() {

	echo '# XScreenSaver Preferences File
	# Written by xscreensaver-settings 6.06 
	# https://www.jwz.org/xscreensaver/

	timeout:	0:05:00
	cycle:		0:00:00
	lock:		True
	lockTimeout:	0:00:00
	passwdTimeout:	0:00:30
	visualID:	default
	installColormap:    True
	verbose:	False
	splash:		True
	splashDuration:	0:00:05
	demoCommand:	xscreensaver-settings
	nice:		10
	fade:		False
	unfade:		False
	fadeSeconds:	0:00:03
	ignoreUninstalledPrograms:False
	dpmsEnabled:	True
	dpmsQuickOff:	True
	dpmsStandby:	0:00:00
	dpmsSuspend:	0:00:00
	dpmsOff:	0:00:00
	grabDesktopImages:  False
	grabVideoFrames:    False
	chooseRandomImages: False
	imageDirectory:	

	mode:		blank
	selected:	155

	textMode:	url
	textLiteral:	XScreenSaver
	textFile:	
	textProgram:	fortune
	textURL:	https://planet.debian.org/rss20.xml
	dialogTheme:	default
	settingsGeom:	12,27 -1,-1

	programs:								      \
					maze --root				    \n\
	- GL: 				superquadrics --root			    \n\
					attraction --root			    \n\
					blitspin --root				    \n\
					greynetic --root			    \n\
					helix --root				    \n\
					hopalong --root				    \n\
					imsmap --root				    \n\
	-				noseguy --root				    \n\
	-				pyro --root				    \n\
					qix --root				    \n\
	-				rocks --root				    \n\
					rorschach --root			    \n\
					decayscreen --root			    \n\
					flame --root				    \n\
					halo --root				    \n\
					slidescreen --root			    \n\
					pedal --root				    \n\
					bouboule --root				    \n\
	-				braid --root				    \n\
					coral --root				    \n\
					deco --root				    \n\
					drift --root				    \n\
	-				fadeplot --root				    \n\
					galaxy --root				    \n\
					goop --root				    \n\
					grav --root				    \n\
					ifs --root				    \n\
					unicode --root				    \n\
	- GL: 				jigsaw --root				    \n\
					julia --root				    \n\
	-				kaleidescope --root			    \n\
	- GL: 				moebius --root				    \n\
					moire --root				    \n\
	- GL: 				morph3d --root				    \n\
					mountain --root				    \n\
					munch --root				    \n\
					penrose --root				    \n\
	- GL: 				pipes --root				    \n\
					rdbomb --root				    \n\
	- GL: 				rubik --root				    \n\
	-				sierpinski --root			    \n\
					slip --root				    \n\
	- GL: 				sproingies --root			    \n\
					starfish --root				    \n\
					strange --root				    \n\
					swirl --root				    \n\
					triangle --root				    \n\
					xjack --root				    \n\
					xlyap --root				    \n\
	- GL: 				atlantis --root				    \n\
					bsod --root				    \n\
	- GL: 				bubble3d --root				    \n\
	- GL: 				cage --root				    \n\
	-				crystal --root				    \n\
					cynosure --root				    \n\
					discrete --root				    \n\
					distort --root				    \n\
					epicycle --root				    \n\
					flow --root				    \n\
	- GL: 				glplanet --root				    \n\
					interference --root			    \n\
					kumppa --root				    \n\
	- GL: 				lament --root				    \n\
					moire2 --root				    \n\
	- GL: 				sonar --root				    \n\
	- GL: 				stairs --root				    \n\
					truchet --root				    \n\
	-				vidwhacker --root			    \n\
	-				webcollage --root			    \n\
					blaster --root				    \n\
					bumps --root				    \n\
					ccurve --root				    \n\
					compass --root				    \n\
					deluxe --root				    \n\
	-				demon --root				    \n\
	- GL: 				extrusion --root			    \n\
	-				loop --root				    \n\
					penetrate --root			    \n\
					petri --root				    \n\
					phosphor --root				    \n\
	- GL: 				pulsar --root				    \n\
					ripples --root				    \n\
					shadebobs --root			    \n\
	- GL: 				sierpinski3d --root			    \n\
					spotlight --root			    \n\
					squiral --root				    \n\
					wander --root				    \n\
					xflame --root				    \n\
					xmatrix --root				    \n\
	- GL: 				gflux --root				    \n\
	-				nerverot --root				    \n\
					xrayswarm --root			    \n\
					xspirograph --root			    \n\
	- GL: 				circuit --root				    \n\
	- GL: 				dangerball --root			    \n\
	- GL: 				dnalogo --root				    \n\
	- GL: 				engine --root				    \n\
	- GL: 				flipscreen3d --root			    \n\
	- GL: 				gltext --root				    \n\
	- GL: 				menger --root				    \n\
	- GL: 				molecule --root				    \n\
					rotzoomer --root			    \n\
					scooter --root				    \n\
					speedmine --root			    \n\
	- GL: 				starwars --root				    \n\
	- GL: 				stonerview --root			    \n\
					vermiculate --root			    \n\
					whirlwindwarp --root			    \n\
					zoom --root				    \n\
					anemone --root				    \n\
					apollonian --root			    \n\
	- GL: 				boxed --root				    \n\
	- GL: 				cubenetic --root			    \n\
	- GL: 				endgame --root				    \n\
					euler2d --root				    \n\
					fluidballs --root			    \n\
	- GL: 				flurry --root				    \n\
	- GL: 				glblur --root				    \n\
	- GL: 				glsnake --root				    \n\
					halftone --root				    \n\
	- GL: 				juggler3d --root			    \n\
	- GL: 				lavalite --root				    \n\
	-				polyominoes --root			    \n\
	- GL: 				queens --root				    \n\
	- GL: 				sballs --root				    \n\
	- GL: 				spheremonics --root			    \n\
					twang --root				    \n\
	- GL: 				antspotlight --root			    \n\
					apple2 --root				    \n\
	- GL: 				atunnel --root				    \n\
					barcode --root				    \n\
	- GL: 				blinkbox --root				    \n\
	- GL: 				blocktube --root			    \n\
	- GL: 				bouncingcow --root			    \n\
					cloudlife --root			    \n\
	- GL: 				cubestorm --root			    \n\
					eruption --root				    \n\
	- GL: 				flipflop --root				    \n\
	- GL: 				flyingtoasters --root			    \n\
					fontglide --root			    \n\
	- GL: 				gleidescope --root			    \n\
	- GL: 				glknots --root				    \n\
	- GL: 				glmatrix --root				    \n\
	- GL: 				glslideshow --root			    \n\
	- GL: 				hypertorus --root			    \n\
	- GL: 				jigglypuff --root			    \n\
					metaballs --root			    \n\
	- GL: 				mirrorblob --root			    \n\
					piecewise --root			    \n\
	- GL: 				polytopes --root			    \n\
					pong --root				    \n\
					popsquares --root			    \n\
	- GL: 				surfaces --root				    \n\
					xanalogtv --root			    \n\
					abstractile --root			    \n\
					anemotaxis --root			    \n\
	- GL: 				antinspect --root			    \n\
					fireworkx --root			    \n\
					fuzzyflakes --root			    \n\
					interaggregate --root			    \n\
					intermomentary --root			    \n\
					memscroller --root			    \n\
	- GL: 				noof --root				    \n\
					pacman --root				    \n\
	- GL: 				pinion --root				    \n\
	- GL: 				polyhedra --root			    \n\
	- GL: 				providence --root			    \n\
					substrate --root			    \n\
					wormhole --root				    \n\
	- GL: 				antmaze --root				    \n\
	- GL: 				boing --root				    \n\
					boxfit --root				    \n\
	- GL: 				carousel --root				    \n\
					celtic --root				    \n\
	- GL: 				crackberg --root			    \n\
	- GL: 				cube21 --root				    \n\
					fiberlamp --root			    \n\
	- GL: 				fliptext --root				    \n\
	- GL: 				glhanoi --root				    \n\
	- GL: 				tangram --root				    \n\
	- GL: 				timetunnel --root			    \n\
	- GL: 				glschool --root				    \n\
	- GL: 				topblock --root				    \n\
	- GL: 				cubicgrid --root			    \n\
					cwaves --root				    \n\
	- GL: 				gears --root				    \n\
	- GL: 				glcells --root				    \n\
	- GL: 				lockward --root				    \n\
					m6502 --root				    \n\
	- GL: 				moebiusgears --root			    \n\
	- GL: 				voronoi --root				    \n\
	- GL: 				hypnowheel --root			    \n\
	- GL: 				klein --root				    \n\
	-				lcdscrub --root				    \n\
	- GL: 				photopile --root			    \n\
	- GL: 				skytentacles --root			    \n\
	- GL: 				rubikblocks --root			    \n\
	- GL: 				companioncube --root			    \n\
	- GL: 				hilbert --root				    \n\
	- GL: 				tronbit --root				    \n\
	- GL: 				geodesic --root				    \n\
					hexadrop --root				    \n\
	- GL: 				kaleidocycle --root			    \n\
	- GL: 				quasicrystal --root			    \n\
	- GL: 				unknownpleasures --root			    \n\
					binaryring --root			    \n\
	- GL: 				cityflow --root				    \n\
	- GL: 				geodesicgears --root			    \n\
	- GL: 				projectiveplane --root			    \n\
	- GL: 				romanboy --root				    \n\
					tessellimage --root			    \n\
	- GL: 				winduprobot --root			    \n\
	- GL: 				splitflap --root			    \n\
	- GL: 				cubestack --root			    \n\
	- GL: 				cubetwist --root			    \n\
	- GL: 				discoball --root			    \n\
	- GL: 				dymaxionmap --root			    \n\
	- GL: 				energystream --root			    \n\
	- GL: 				hexstrut --root				    \n\
	- GL: 				hydrostat --root			    \n\
	- GL: 				raverhoop --root			    \n\
	- GL: 				splodesic --root			    \n\
	- GL: 				unicrud --root				    \n\
	- GL: 				esper --root				    \n\
	- GL: 				vigilance --root			    \n\
	- GL: 				crumbler --root				    \n\
					filmleader --root			    \n\
					glitchpeg --root			    \n\
	- GL: 				handsy --root				    \n\
	- GL: 				maze3d --root				    \n\
	- GL: 				peepers --root				    \n\
	- GL: 				razzledazzle --root			    \n\
					vfeedback --root			    \n\
	- GL: 				deepstars --root			    \n\
	- GL: 				gravitywell --root			    \n\
	- GL: 				beats --root				    \n\
	- GL: 				covid19 --root				    \n\
	- GL: 				etruscanvenus --root			    \n\
	- GL: 				gibson --root				    \n\
	- GL: 				headroom --root				    \n\
	- GL: 				sphereeversion --root			    \n\
					binaryhorizon --root			    \n\
					marbling --root				    \n\
	- GL: 				chompytower --root			    \n\
	- GL: 				hextrail --root				    \n\
	- GL: 				mapscroller --root			    \n\
	- GL: 				nakagin --root				    \n\
	- GL: 				squirtorus --root			    \n\


	pointerHysteresis:  10
	authWarningSlack:   20

	' >> $HOME/.xscreensaver

	}
	confXSSPC

fi



# echo '######################## BATERIA ##############################'

#mkdir -p $HOME/.config/scripts

#echo "'
	##!/bin/bash
	
	
	## Obtener el nivel de batería
	#battery_level=$(acpi -b | grep -P -o "[0-9]+(?=%)")

	## Comprobar si el nivel de batería es bajo
	#if [ "$battery_level" -lt 101 ]; then
		## Mostrar notificación
		#xmessage -center -buttons Aceptar:OK -default Aceptar -title "AVISO: Bateria baja" -bg \#FFAA00 -fg \#000000 -geometry 400x200 El nivel de la bateria es del $battery_level%. &
	#fi

#' > $HOME/.config/scripts/batteryCheck.sh

#chmod +x $HOME/.config/scripts/batteryCheck.sh

#sudo sed -i '$a */2 *  *  *  *   '"$USER"'    '"$HOME"'/.config/scripts/batteryCheck.sh' /etc/crontab






