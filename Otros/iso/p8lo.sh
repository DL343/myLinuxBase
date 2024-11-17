#!/usr/bin/env bash

apt update
apt -y upgrade


echo "
########################################################################
############################## LPKG ##############################
########################################################################
"

apt -y install lpkg glpkg 


echo "
########################################################################
############################## REPO MANAGER ##############################
########################################################################
"

## Instalacion
apt -y install repo-manager-loc-os


echo "
########################################################################
############################## WELCOME ##############################
########################################################################
"

## Instalacion
apt -y install welcome-loc-os

### Cambio de iconos
#cp ./LO/Welcome/waterfox.png  /opt/browsers/icons/

### Ajuste script eliminacion (firefox => waterfox)
#cp ./LO/Welcome/chromium.sh /opt/browsers/scripts/chromium.sh

### Ajuste textos interfaz yad
#cp ./LO/Welcome/browsers.sh /bin/browsers.sh









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


###### CALAMARES LO
mkdir -p /home/live/Desktop/
echo "
[Desktop Entry]
Type=Application
Version=1.0
Name=Install Loc-OS
GenericName=System Installer
Keywords=calamares;system;installer;
TryExec=
Exec=sh -c '/bin/install-loc-os' 
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

" > /home/live/Desktop/Install.desktop



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





chown live:live -R /home/live/

