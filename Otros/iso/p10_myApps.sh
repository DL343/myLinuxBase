#!/bin/bash

apt update
apt -y upgrade


sudo apt -y install   xorg	bash-completion   gparted 	\
btrfs-progs   mtools   pcmanfm   sakura   acpi   gcr   unar   keyutils ncdu   gtk2-engines-pixbuf \
nano   gvfs   xarchiver   policykit-1-gnome   brightnessctl   xdg-user-dirs 
	
	 
sudo apt -y install   htop   btop   fastfetch   p7zip-full   lm-sensors inxi  \
lxappearance    lxrandr   \
parcellite 	    rofi  	flameshot	mirage	nitrogen	redshift	bleachbit    mpv  \
evince   plasma-discover   geany




sudo apt -y install volumeicon-alsa   numlockx   xdg-desktop-portal



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

apt install console-data  	
