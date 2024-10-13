#!/usr/bin/env bash

source ./variables.sh

apt update
apt -y upgrade


echo "
########################################################################
############################ SKEL Y LIVE ###############################
########################################################################
"

## Eliminacion rastros anteriores
rm -r /home/live/

## Creacion de la carpeta por si no existe
mkdir -p /etc/skel

## Copia de home's
cp -r ./sesion/skel/ /etc/
cp -r ./sesion/skel/ /home/live/

## Ajuste de permisos
chown live /home/live -R



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
' > /etc/skel/.config/scripts/toggle_network-applet.sh 



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

fi

######## ICEWM: DESHABILITAR POLKIT GNOME EN LIVE
if grep -q "#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else

	sed -i '/\/usr\/lib\/policykit-1-gnome\/polkit-gnome-authentication-agent-1 &/c #\/usr\/lib\/policykit-1-gnome\/polkit-gnome-authentication-agent-1 &' /home/live/.icewm/startup

fi





## Ajuste resolucion pantalla
##sh -c 'xrandr --output Virtual-1 --mode 1280x768' &



########## ICEWM: AJUSTE PERMISOS APAGADO/REINICIO/SUSPENSION
mkdir -p /etc/sudoers.d/

echo "
ALL ALL=(ALL) NOPASSWD: /sbin/reboot
ALL ALL=(ALL) NOPASSWD: /sbin/poweroff
ALL ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend
" > /etc/sudoers.d/icewm




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





#echo "
#########################################################################
########################### DISPLAY MANAGER #############################
#########################################################################
#"

### LXDM
#apt -y install lxdm 
#apt -y install lxdm-loc-os

#sed -i '/session=/c session=/usr/bin/icewm-session' /etc/lxdm/default.conf
#sed -i '/numlock=/c numlock=1' /etc/lxdm/default.conf




echo "
########################################################################
########################## DISPLAY MANAGER #############################
########################################################################
"

##### LIGHTDM: DEPENDENCIA
apt -y install numlockx

## LIGHTDM: INSTALACION
sudo apt -y install lightdm lightdm-gtk-greeter --no-install-recommends 

##### LIGHTDM: AUTOLOGIN LIVE
sed -i '/autologin-user=/c autologin-user=live' /etc/lightdm/lightdm.conf
sed -i '/autologin-user-timeout=/c autologin-user-timeout=0' /etc/lightdm/lightdm.conf
sed -i '/autologin-session=/c autologin-session=icewm-session' /etc/lightdm/lightdm.conf

##### LIGHTDM: BLOQ NUM ACTIVADO POR DEFECTO
sed -i '/greeter-setup-script=/c greeter-setup-script=/usr/bin/numlockx on' /etc/lightdm/lightdm.conf

##### LIGHTDM: MOSTAR USUARIOS DISPONIBLES
sed -i '/greeter-hide-users=/c greeter-hide-users=false' /usr/share/lightdm/lightdm.conf.d/01_debian.conf 

###### LIGHTDM: WALLPAPER
#sed -i '/background=/c background=/usr/share/wallpapers/loquitux_orquidea.png'  /etc/lightdm/lightdm-gtk-greeter.conf

###### LIGHTDM: TEMA
#sed -i '/theme-name=/c theme-name=DarkAndGolden'  /etc/lightdm/lightdm-gtk-greeter.conf

###### LIGHTDM: ICONOS
#sed -i '/icon-theme-name=/c icon-theme-name=Tela-grey-dark'  /etc/lightdm/lightdm-gtk-greeter.conf

if grep -q "background=/usr/share/wallpapers/loquitux_orquidea.png" /etc/lightdm/lightdm-gtk-greeter.conf
then

	echo "Existe ajuste, omitiendo este paso"

else

echo "
background=/usr/share/wallpapers/loquitux_orquidea.png
theme-name=DarkAndGolden
icon-theme-name=Tela-grey-dark
" >> /etc/lightdm/lightdm-gtk-greeter.conf

fi


########################################################################






########################################################################





########################################################################





if [ "sysvinit" == "${init}" ]
then
	
	
	## Autoinicio de Welcome para iceWM
if grep -q "/bin/loc-oswelcome.sh" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "
## Script inicio
/bin/loc-oswelcome.sh

" >>  /home/live/.icewm/startup 
fi


echo "
########################################################################
############################## CALAMARES ##############################
########################################################################
"
## IMG: Icono 
#cp ./LO/Calamares/calamares-loc-os.png /home/live/
#

## Entrada en el escritorio
mkdir -p /home/live/Desktop/


###### BROWSERS => CALAMARES
#echo "
#[Desktop Entry]
#Type=Application
#Version=1.0
#Name=Install Loc-OS
#GenericName=System Installer
#Keywords=calamares;system;installer;
#TryExec=browsers.sh
#Exec=browsers.sh
#Comment=Loc-OS — System Installer
#Icon=/usr/share/icons/hicolor/48x48/apps/calamares-loc-os.png
#Terminal=false
#StartupNotify=true
#Categories=Qt;System;
#X-AppStream-Ignore=true

#Name[es]=Instalar el sistema
#GenericName[es]=Instalador del sistema
#Name[es_MX]=Instalar el Sistema
#Icon[es_MX]=calamares
#GenericName[es_MX]=Instalador del sistema
#Name[es_PR]=Instalar el sistema
#Name[pt]=Instalar Sistema
#Name[pt_BR]=Instalar Sistema
#Name[pt_PT]=Instalar Sistema
#GenericName[pt_PT]=Instalador de Sistema
#Hidden=false

#" > /home/live/Desktop/install.desktop


###### CALAMARES
echo "
[Desktop Entry]
Type=Application
Version=1.0
Name=Install Loc-OS
GenericName=System Installer
Keywords=calamares;system;installer;
TryExec=
Exec=install-loc-os 
Comment=Loc-OS — System Installer
Icon=/usr/share/icons/hicolor/48x48/apps/calamares-loc-os.png
Terminal=false
StartupNotify=true
Categories=Qt;System;
X-AppStream-Ignore=true

Name[es]=Instalar el sistema
GenericName[es]=Instalador del sistema
Name[es_MX]=Instalar el Sistema
Icon[es_MX]=calamares
GenericName[es_MX]=Instalador del sistema
Name[es_PR]=Instalar el sistema
Name[pt]=Instalar Sistema
Name[pt_BR]=Instalar Sistema
Name[pt_PT]=Instalar Sistema
GenericName[pt_PT]=Instalador de Sistema
Hidden=false

" > /home/live/Desktop/install.desktop



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

chown live:live -R /home/live/
fi



echo "backend: apt

operations:
  - remove:
      - 'live-boot'
      - 'live-boot-doc'
      - 'live-config'
      - 'live-config-doc'
      - 'live-tools'
      - 'calamares'
      - 'calamares-settings-loc-os'
      - 'welcome-loc-os'" > /etc/calamares/modules/packages.conf
      
      


echo "
#!/bin/sh

pkill yad

###
# Wrapper for running calamares on Loc-OS live media
###

# Stale file left behind by live-build that messes with partitioning
sudo mv /etc/fstab /etc/fstab.orig.calamares

# Allow Calamares to scale the window for hidpi displays
# This is fixed in the Calamares 3.3.0 series, so we can remove this
# once we switch to that
# Upstream commit that will make this obsolete:
#     https://github.com/calamares/calamares/commit/e9f011b686a0982fb7828e8ac02a8e0784d3b11f
# Upstream bug:
#     https://github.com/calamares/calamares/issues/1945
# Debian bug:
#     https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=992162
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# Access control to run calamares as root for xwayland
xhost +si:localuser:root
pkexec calamares $@
xhost -si:localuser:root

# Restore stale fstab, for what it's worth
sudo mv /etc/fstab.orig.calamares /etc/fstab

" > /usr/bin/install-loc-os


update-grub
update-initramfs -u
sudo init q



