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

echo "#########################################"


















###### SDDM: INSTALACION
#apt install sddm --no-install-recommends 


###### SDDM: CONFIGURACION
#echo "
#[Theme]
## Current theme name
#Current=breeze



#[Autologin]
#User=live
#Session=icewm-session

#" > /etc/sddm.conf

###### SDDM: APLICANDO TEMA
#mkdir -p /usr/share/sddm/themes
#cp -r ./custom/dm/breeze/    /usr/share/sddm/themes/

###### SDDM: APLICANDO IMAGEN PERFIL USUARIO
#cp  ./custom/dm/face.png   /home/live/.face.icon  
#cp  ./custom/dm/face.png   /etc/skel/.face.icon 


###### SDDM: WALLPAPER CUSTOM
#echo "
#[General]
#background=/usr/share/wallpapers/loquitux_orquidea.png 
#" > /usr/share/sddm/themes/breeze/theme.conf.user


##### FLATPAK

sudo apt -y install   htop   btop   fastfetch   p7zip-full   lm-sensors inxi  \
lxappearance    lxrandr   \
parcellite 	    rofi  		nitrogen	redshift	 \
plasma-discover   




sudo apt -y install volumeicon-alsa   numlockx   xdg-desktop-portal




flatpak install flathub org.flameshot.Flameshot
flatpak install flathub org.nomacs.ImageLounge
flatpak install flathub org.bleachbit.BleachBit
flatpak install flathub io.mpv.Mpv
flatpak install flathub org.gnome.Evince
flatpak install flathub org.geany.Geany
flatpak install flathub io.gitlab.librewolf-community






echo "
########################################################################
                              TIENDA APPS
########################################################################
"
##### PLASMA-DISCOVER
sudo apt install breeze-icon-theme plasma-discover qml-module-org-kde-purpose libkf5purpose-dev    
apt -y purge kdeconnect



echo "
########################################################################
                               LIBINPUT
########################################################################
" 


if [ "$(sed -n '/Option "Tapping" "true"/p' /usr/share/X11/xorg.conf.d/40-libinput.conf)" == 'Option "Tapping" "true"' ]; then 

	echo "Perfecto!, existe la configracion, omitiendo este paso...";

else 

   echo "No existe la configuracion, aplicando...."
   sudo sed -i '/Identifier "libinput touchpad catchall"/a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf

   echo "Listo"
fi


echo "
########################################################################
                               UFW
########################################################################
" 


apt install ufw
## Permitir el trafico saliente
#sudo ufw default allow outgoing

## Bloquear el trafico entrante
#sudo ufw default deny incoming

## Permitir trafico ssh
#sudo ufw allow ssh

# Activacion ufw
sudo ufw enable 



echo '
########################################################################
                           AUDIO
########################################################################
'

sudo apt -y install libconfig++9v5 libffado2 liblua5.4-0 libpipewire-0.3-modules libroc0.3 libspeexdsp1 libwireplumber-0.4-0 libxml++2.6-2v5 pipewire pipewire-bin pipewire-pulse  wireplumber  pulseaudio-utils  wireplumber-doc	pavucontrol 




echo '
########################################################################
                      CONFIGURACION DE GRUB
########################################################################'
### Contador a 1 segundo
sudo sed -i '/GRUB_TIMEOUT=/c GRUB_TIMEOUT=1' /etc/default/grub

### Guardar la ultima particion seleccionada
sudo sed -i '/GRUB_DEFAULT=/c GRUB_DEFAULT=saved' /etc/default/grub

if grep -q "GRUB_SAVEDEFAULT=true" /etc/default/grub
then

	echo "Existe 'GRUB_SAVEDEFAULT=true' omitiendo este paso"

else

	sudo sed -i '/GRUB_DEFAULT=saved/a GRUB_SAVEDEFAULT=true' /etc/default/grub

fi




## Actualizar cambios a grub
sudo update-grub




echo '
########################################################################
                             BLUETOOTH
########################################################################
'



	echo "## Instalando paquetes para bluetooth..."

	###               Soporte basico para bluetooth       Interfaz grafica para la gestion
	sudo apt -y install  bluez                               blueman -y
	

	
	

#echo '
#########################################################################
                            #INTERFACES
#########################################################################
#'

#echo '## Deshabilitar "interfaces"'
#sudo mv /etc/network/interfaces /etc/network/interfaces.old






echo "
########################################################################
                              SWAPPINESS
########################################################################
"
## Ajuste swappines 
if grep -q 'vm.swappiness=' /etc/sysctl.conf
then
	echo "Texto encontrado, ajustando..."
	sudo sed -i '/vm.swappiness=/c vm.swappiness=15' /etc/sysctl.conf

else
	echo "Texto no encontrado, añadiendo..."
	echo "vm.swappiness=15" | sudo tee -a /etc/sysctl.conf > /dev/null
	
fi



echo "
########################################################################
                              NAVEGADORES
########################################################################
"

apt -y install librewolf







echo "
########################################################################
############################### TTY'S ##################################
########################################################################
"

######## NUM BLOQ ACTIVADO EN TTY'S
#if grep -q 'setleds -D +num < $tty' /etc/rc.local
#then
	#echo 'Existe "setleds -D +num < $tty", omitiendo este paso...'
#else
#echo '
#for tty in /dev/tty[0-9]*; do
        #setleds -D +num < $tty
#done
#' >> /etc/rc.local 

#fi


########## Reduciendo numero de tty's (sysVinit)
## Ajuste al archivo
sed -i '/4:23:respawn:\/sbin\/getty/c #4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
sed -i '/5:23:respawn:\/sbin\/getty/c #5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
sed -i '/6:23:respawn:\/sbin\/getty/c #6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab


########## REMOVIENDO SERVICIOS 
update-rc.d -f cron remove

apt -y purge avahi-daemon  at-spi2-core  rtkit 
#git





echo "
########################################################################
                              LIMPIEZA
########################################################################
"

apt -y purge aspell-es chafa cups-pk-helper debian-reference-es \
debian-reference-common fonts-liberation ispanish task-spanish \
manpages-es system-config-printer system-config-printer-common \
system-config-printer-udev  python3-cupshelpers python3-cups xterm



echo "
########################################################################
                              AJUSTES
########################################################################
"

pactl set-sink-volume @DEFAULT_SINK@ 25%
update-rc.d -f nftables remove
apt install console-data  	
