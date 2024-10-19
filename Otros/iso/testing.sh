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


###### FLATPAK

#sudo apt -y install   htop   btop   fastfetch   p7zip-full   lm-sensors inxi  \
#lxappearance    lxrandr   \
#parcellite 	    rofi  		nitrogen	redshift	 \
#plasma-discover   




#sudo apt -y install volumeicon-alsa   numlockx   xdg-desktop-portal




#flatpak install flathub org.flameshot.Flameshot
#flatpak install flathub org.nomacs.ImageLounge
#flatpak install flathub org.bleachbit.BleachBit
#flatpak install flathub io.mpv.Mpv
#flatpak install flathub org.gnome.Evince
#flatpak install flathub org.geany.Geany
#flatpak install flathub io.gitlab.librewolf-community






#echo "
#########################################################################
                              #TIENDA APPS
#########################################################################
#"
###### PLASMA-DISCOVER
#sudo apt install breeze-icon-theme plasma-discover qml-module-org-kde-purpose libkf5purpose-dev    
#apt -y purge kdeconnect



#echo "
#########################################################################
                               #LIBINPUT
#########################################################################
#" 


#if [ "$(sed -n '/Option "Tapping" "true"/p' /usr/share/X11/xorg.conf.d/40-libinput.conf)" == 'Option "Tapping" "true"' ]; then 

	#echo "Perfecto!, existe la configracion, omitiendo este paso...";

#else 

   #echo "No existe la configuracion, aplicando...."
   #sudo sed -i '/Identifier "libinput touchpad catchall"/a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf

   #echo "Listo"
#fi


#echo "
#########################################################################
                               #UFW
#########################################################################
#" 


#apt install ufw
### Permitir el trafico saliente
##sudo ufw default allow outgoing

### Bloquear el trafico entrante
##sudo ufw default deny incoming

### Permitir trafico ssh
##sudo ufw allow ssh

## Activacion ufw
#sudo ufw enable 



#echo '
#########################################################################
                           #AUDIO
#########################################################################
#'

#sudo apt -y install libconfig++9v5 libffado2 liblua5.4-0 libpipewire-0.3-modules libroc0.3 libspeexdsp1 libwireplumber-0.4-0 libxml++2.6-2v5 pipewire pipewire-bin pipewire-pulse  wireplumber  pulseaudio-utils  wireplumber-doc	pavucontrol 




#echo '
#########################################################################
                      #CONFIGURACION DE GRUB
#########################################################################'
#### Contador a 1 segundo
#sudo sed -i '/GRUB_TIMEOUT=/c GRUB_TIMEOUT=1' /etc/default/grub

#### Guardar la ultima particion seleccionada
#sudo sed -i '/GRUB_DEFAULT=/c GRUB_DEFAULT=saved' /etc/default/grub

#if grep -q "GRUB_SAVEDEFAULT=true" /etc/default/grub
#then

	#echo "Existe 'GRUB_SAVEDEFAULT=true' omitiendo este paso"

#else

	#sudo sed -i '/GRUB_DEFAULT=saved/a GRUB_SAVEDEFAULT=true' /etc/default/grub

#fi




### Actualizar cambios a grub
#sudo update-grub




#echo '
#########################################################################
                             #BLUETOOTH
#########################################################################
#'



	#echo "## Instalando paquetes para bluetooth..."

	####               Soporte basico para bluetooth       Interfaz grafica para la gestion
	#sudo apt -y install  bluez                               blueman -y
	

	
	

##echo '
##########################################################################
                            ##INTERFACES
##########################################################################
##'

##echo '## Deshabilitar "interfaces"'
##sudo mv /etc/network/interfaces /etc/network/interfaces.old






#echo "
#########################################################################
                              #SWAPPINESS
#########################################################################
#"
### Ajuste swappines 
#if grep -q 'vm.swappiness=' /etc/sysctl.conf
#then
	#echo "Texto encontrado, ajustando..."
	#sudo sed -i '/vm.swappiness=/c vm.swappiness=15' /etc/sysctl.conf

#else
	#echo "Texto no encontrado, añadiendo..."
	#echo "vm.swappiness=15" | sudo tee -a /etc/sysctl.conf > /dev/null
	
#fi



#echo "
#########################################################################
                              #NAVEGADORES
#########################################################################
#"

#apt -y install librewolf







#echo "
#########################################################################
################################ TTY'S ##################################
#########################################################################
#"

######### NUM BLOQ ACTIVADO EN TTY'S
##if grep -q 'setleds -D +num < $tty' /etc/rc.local
##then
	##echo 'Existe "setleds -D +num < $tty", omitiendo este paso...'
##else
##echo '
##for tty in /dev/tty[0-9]*; do
        ##setleds -D +num < $tty
##done
##' >> /etc/rc.local 

##fi


########### Reduciendo numero de tty's (sysVinit)
### Ajuste al archivo
#sed -i '/4:23:respawn:\/sbin\/getty/c #4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
#sed -i '/5:23:respawn:\/sbin\/getty/c #5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
#sed -i '/6:23:respawn:\/sbin\/getty/c #6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab


########### REMOVIENDO SERVICIOS 
#update-rc.d -f cron remove

#apt -y purge avahi-daemon  at-spi2-core  rtkit 
##git





#echo "
#########################################################################
                              #LIMPIEZA
#########################################################################
#"

#apt -y purge aspell-es chafa cups-pk-helper debian-reference-es \
#debian-reference-common fonts-liberation ispanish task-spanish \
#manpages-es system-config-printer system-config-printer-common \
#system-config-printer-udev  python3-cupshelpers python3-cups xterm



#echo "
#########################################################################
                              #AJUSTES
#########################################################################
#"

#pactl set-sink-volume @DEFAULT_SINK@ 25%
#update-rc.d -f nftables remove
#apt install console-data  	










apt -y reinstall welcome-loc-os

##################################################
## Instalar KDE Plasma (base minima)
##################################################
apt -y install plasma-desktop



##################################################
## Wallpapers y Temas visuales
##################################################
wget -O /tmp/loquitux.tar.gz https://staging.karlaperezyt.com/locoskde/src/wallpapers/loquitux.tar.gz
wget -O /tmp/colors.tar.gz https://staging.karlaperezyt.com/locoskde/src/themes/FlatRemixYellow.tar.gz
wget -O /tmp/icons.tar.gz https://staging.karlaperezyt.com/locoskde/src/themes/Vimix.tar.gz


mkdir -p /usr/share/wallpapers
mkdir -p /usr/share/color-schemes
mkdir -p /usr/share/icons

tar -xf /tmp/loquitux.tar.gz -C /usr/share/wallpapers
tar -xf /tmp/colors.tar.gz -C /usr/share/color-schemes
tar -xf /tmp/icons.tar.gz -C /usr/share/icons

rm /tmp/loquitux.tar.gz
rm /tmp/colors.tar.gz
rm /tmp/icons.tar.gz

##################################################
## Skel
##################################################
wget -O /tmp/defaults.tar.gz https://staging.karlaperezyt.com/locoskde/src/userconfig/defaults.tar.gz
wget -O /tmp/live.tar.gz https://staging.karlaperezyt.com/locoskde/src/userconfig/live.tar.gz
wget -O /tmp/face.png https://staging.karlaperezyt.com/locoskde/src/userconfig/face.png

mkdir -p /etc/skel

tar -xf /tmp/defaults.tar.gz -C /etc/skel
tar -xf /tmp/live.tar.gz -C /home/live
cp /tmp/face.png /etc/skel/.face

rm /tmp/defaults.tar.gz
rm /tmp/face.png

chown live /home/live -R




##################################################
## Hostname & SDDM
##################################################
echo "[Autologin]
User=live
Session=plasma" > /etc/sddm.conf




##################################################
## Autostarts
##################################################
mkdir -p /etc/xdg/autostart.disabled
mv /etc/xdg/autostart/at-spi-dbus-bus.desktop           /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/klipper.desktop                   /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/xembedsniproxy.desktop            /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/baloo_file.desktop                /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/pam_kwallet_init.desktop          /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/geoclue-demo-agent.desktop        /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/gmenudbusmenuproxy.desktop        /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/kaccess.desktop                   /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/powerdevil.desktop                /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/kup-daemon.desktop                /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/org.kde.discover.notifier.desktop /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/org.kde.kdeconnect.daemon.desktop /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/konqy_preload.desktop             /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/print-applet.desktop              /etc/xdg/autostart.disabled/



##################################################
## Desactivar servicios de plasma
##################################################
apt -y remove kdeconnect

#chmod -x /usr/lib/x86_64-linux-gnu/libexec/kactivitymanagerd
chmod -x /usr/bin/kglobalaccel5
chmod -x /usr/bin/kded5


##################################################
## Desactivar servicios de plasma
##################################################
apt -y remove kdeconnect

#chmod -x /usr/lib/x86_64-linux-gnu/libexec/kactivitymanagerd
chmod -x /usr/bin/kglobalaccel5
chmod -x /usr/bin/kded5

##################################################
## Desactiva plasmoides
##################################################


mkdir /usr/share/plasma/plasmoids.disabled
mv /usr/share/plasma/plasmoids/*   /usr/share/plasma/plasmoids.disabled/
mv /usr/share/plasma/plasmoids.disabled/org.kde.desktopcontainment        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.kscreen                   /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.panel                     /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.volume             /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.systemtray         /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.windowlist         /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.showdesktop        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.private.systemtray /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.panelspacer        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.notifications      /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.lock_logout        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.kicker             /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.kickoff            /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.icontasks          /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.icon               /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.digitalclock       /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.milou                     /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.appmenu            /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.calendar           /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.folder             /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.marginsseparator   /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.taskmanager        /usr/share/plasma/plasmoids/




###########################################################
## COMPLEMENTOS
############################################################

##### APPS
apt -y install chromium kde-spectacle vlc kamera kate ark kcalc gwenview fastfetch okular unrar-free unzip webapp-manager zip libreoffice-calc libreoffice-writer htop imagemagick cmst






mkdir -p /home/live/.config/autostart
echo "[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=Welcome
Comment=
Exec=/bin/loc-oswelcome.sh
OnlyShowIn=KDE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false
" > /home/live/.config/autostart/Welcome.desktop
chown live:live -R /home/live/


if grep -q "CUSTOM KDE" /usr/lib/refractasnapshot/snapshot_exclude.list
then
	echo ":::::'CUSTOM KDE' existe, omitiendo este paso....."
else
echo "####### CUSTOM KDE ########
- /home/*/.config/kate
- /home/*/.config/akregatorrc
- /home/*/.config/dolphinrc
- /home/*/.config/gwenviewrc
- /home/*/.config/katerc
- /home/*/.config/kmixrc
- /home/*/.config/konsolerc
- /home/*/.config/konquerorrc
- /home/*/.config/kwinrc
- /home/*/.config/spectaclerc

- /home/*/.local/share/dolphin/*
- /home/*/.local/share/kate/*
- /home/*/.local/share/klipper/*
- /home/*/.local/share/kscreen/*

" >> /usr/lib/refractasnapshot/snapshot_exclude.list
fi

sed -i '/mksq_opt="-comp xz -Xbcj x86"/c mksq_opt="-comp xz -Xbcj x86"' /etc/refractasnapshot.conf




cat << 'EOF' > /bin/loc-oswelcome.sh
#!/usr/bin/env bash
#=======================HEADER========================================|
#AUTOR
# Nicolas Longardi 'Locos por Linux' <nico@locosporlinux.com>
# Jefferson 'Slackjeff' Rocha <root@slackjeff.com.br>
# Creado totalmente en bash + YAD.
#===================================| VARIABLES
# Nombre del programa
PRG='Loc-OS Welcome'

# Version
VERSION='1.0'

# Archivo temporário para exclusion
temp="/etc/xdg/autostart/loc-oswelcome.desktop"

# Ubicacion de los iconos
icon='/usr/share/pixmaps/loc-oswelcome'

#===================================| INICIO
# Menu Principal
 yad --title="$PRG"            \
    --width="800"              \
    --height="450"             \
    --text-align=left          \
    --center                   \
    --image-on-top             \
    --undecorated              \
    --fontname="monospace 56"  \
    --image="${icon}/logo.png" \
    --borders=10               \
    --text="
<big><b>Loc-OS</b> Welcome</big>

Welcome, below you can check some options to install or configure the system.
Remember that the password of the <big><b>live</b></big> user is <big><b>live</b></big> and that of <big><b>root</b></big> is <big><b>root</b></big>."   \
   --form  --columns 4                                                                                     \
    --field="<b>Install</b>!${icon}/install.png!Install Loc-OS Linux on the HDD/SSD":BTN "/usr/bin/install-loc-os " \
    --field="<b>Website</b>!${icon}/site.png!Official site of Loc-OS":BTN "xdg-open https://loc-os.sourceforge.io/"           \
    --field="<b>LPKG</b>!${icon}/lpkg.png!Loc-OS Package Manager":BTN "/opt/Loc-OS-LPKG/.sudo/sudogui /opt/Loc-OS-LPKG/LpkgGui"   \ "
yad --width='500'
     --height='100'
     --center
     --undecorated
     --image="${icon}/sobreyad.png"
     --borders=5
     --text-align=left
     --text='

<big><b>$PRG</b></big>

Loc-OS Linux is a free GNU/Linux distribution, oriented to low resource consumption. Free from systemd and based on Debian stable.

<b>Version:</b> $VERSION
<b>License:</b> GPLv3
<b>Contact:</b> nico@locosporlinux.com'
     --button="Exit":1
"                                                                                                           \ "
"                                                                                                       \
    --field="<b>About</b>!${icon}/sobre.png!About this proyect":BTN  "xdg-open ${sites[4]}"            \
    --button="Exit":1

# El inicio automatico debe ser apenas en el primer boot.
# Luego debe ser excluido.
if [[ -e "$temp" ]]; then
    rm "$temp"
fi

EOF


mkdir -p /home/live/Desktop/
echo "
[Desktop Entry]
Type=Application
Version=1.0
Name=Install Loc-OS
GenericName=System Installer
Keywords=calamares;system;installer;
TryExec=calamares
Exec=sh -c \"pkexec calamares\"
Comment=Calamares — System Installer
Icon=/usr/share/icons/hicolor/48x48/apps/calamares-loc-os.png
Terminal=false
StartupNotify=true
Categories=Qt;System;
X-AppStream-Ignore=true
" > /home/live/Desktop/Instalar.desktop









##################################################
## Elimina residuos
##################################################

apt -y purge apparmor aspell-es bup chafa cups-pk-helper debian-reference-es debian-reference-common fonts-freefont-ttf fonts-liberation git ispanish kdeconnect konqueror kpeople-vcard kup-backup kwrite manpages-es mlocate par2 partitionmanager plasma-browser-integration plasma-disks plocate python3-cairo python3-cups python3-cupshelpers python3-fuse python3-pylibacl python3-smbc python3-tornado rtkit smartmontools sshfs system-config-printer vim-tiny zutty

##### NETWORK
apt -y purge network-manager xterm


apt -y autoremove

rm /home/live/Desktop/install.desktop


