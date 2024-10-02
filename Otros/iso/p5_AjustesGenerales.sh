#!/usr/bin/env bash

source ./variables.sh


apt update
apt upgrade



if [ "systemd" == "${init}" ]
then
	echo "
	########################################################################
	############################  CALAMARES ################################
	########################################################################
	"

	## Icono de la aplicacion calamares (48x48.png)
	#cp ./???.png /usr/share/icons/hicolor/48x48/apps/???.png


	## Aplicacion
	#??????cp ./instaladorCalamares/calamares.desktop /home/live/Desktop/Instalar.desktop
	
	## Configuracion general
	cp ./instaladorCalamares/settings.conf /etc/calamares/

	## MODULO: Remover usuario live
	cp ./instaladorCalamares/removeuser.conf /etc/calamares/modules/

	## MODULO: Añadidos en la seleccion de particiones
	cp ./instaladorCalamares/partition.conf /etc/calamares/modules/
	
	## Se añade la linea para eliminar usuario
	if grep -q "  - removeuser" /etc/calamares/settings.conf
	then
	
		echo "El ajuste '## Se añade la linea para eliminar usuario' existe, omitiendo este paso..."
		
	else
	perl -i -pe '
		BEGIN { $count = 0 } 
		if (/keyboard/) { 
			$count++; 
			if ($count == 2) { 
				print "  - removeuser\n" 
			} 
		}' /etc/calamares/settings.conf
	fi
	
	

## CALAMARES: IMAGENES 
dirORIGEN=./custom/calamares/
## 256 x 256
install -D $dirORIGEN/01.png     /etc/calamares/branding/debian/debian-logo.png

## 457 × 300
install -D $dirORIGEN/02.png     /etc/calamares/branding/debian/welcome.png


## CALAMARES: SLIDES
## 830 × 608
mkdir -p /etc/calamares/branding/debian/slides/
cp $dirORIGEN/slides/*        /etc/calamares/branding/debian/slides/



####### CALAMARES: CONFIGURACION "BRANDING" 
echo "
---
componentName:   debian
welcomeStyleCalamares: true
welcomeExpandingLogo: true
windowExpanding: normal
windowSize: 800px,520px
windowPlacement: center

strings:
    productName:         "${nombreDistro}" GNU/Linux
    shortProductName:    "${nombreDistro}"
    version:             "${numVersion}" "${codeName}"
    shortVersion:        "${numVersion}"
    versionedName:       "${nombreDistro}" "${numVersion}" "${codeName}"
    shortVersionedName:  "${nombreDistro}" "${numVersion}"
    bootloaderEntryName: "${nombreDistro}"
    productUrl:          "${productUrl}"
    supportUrl:          "${supportUrl}"
    knownIssuesUrl:      "${knownIssuesUrl}"
    releaseNotesUrl:     "${releaseNotesUrl}"
    donateUrl:           "${donateUrl}"

images:
    productLogo:         \"debian-logo.png\"
    productIcon:         \"debian-logo.png\"
    productWelcome:      \"welcome.png\"
    # productWallpaper:  \"wallpaper.png\"

slideshow:               \"show.qml\"

style:
   sidebarBackground:    \"#2c3133\"
   sidebarText:          \"#FFFFFF\"
   sidebarTextSelect:    \"#4d7079\"
   sidebarTextSelect:    \"#292F34\"

slideshowAPI: 2

"  > /etc/calamares/branding/debian/branding.desc



######## CONFIGURACION SLIDES
echo "
/* === This file is part of Calamares - <http://github.com/calamares> ===
 *
 *   Copyright 2015, Teo Mrnjavac <teo@kde.org>
 *   Copyright 2018-2019, Jonathan Carter <jcc@debian.org>
 *
 *   Calamares is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, or (at your option) any later version.
 *
 *   Calamares is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Calamares. If not, see <http://www.gnu.org/licenses/>.
 */
 
 import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 40000
        running: true
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }
Slide 
{
        anchors.fill: parent

        Image {
            id: background1
            source: \"slides/01.png\"
            anchors.fill: parent
        
        }
}   
Slide 
{
        anchors.fill: parent

        Image {
            id: background2
            source: \"slides/02.png\"
            anchors.fill: parent
        
        }
}   
Slide 
{
        anchors.fill: parent

        Image {
            id: background3
            source: \"slides/03.png\"
            anchors.fill: parent
        
    }
}   
Slide 
{
        anchors.fill: parent

        Image {
            id: background4
            source: \"slides/04.png\"
            anchors.fill: parent
        
        }
    }

Slide 
{
        anchors.fill: parent

        Image {
            id: background5
            source: \"slides/05.png\"
            anchors.fill: parent
        
        }
    }
    
}

 
" > /etc/calamares/branding/debian/show.qml




	echo "
	########################################################################
	########################## DISPLAY MANAGER #############################
	########################################################################
	"
	## LIGHTDM
	apt -y install lightdm lightdm-gtk-greeter 
	
	sed -i '/autologin-user=/c autologin-user=live' /etc/lightdm/lightdm.conf
	sed -i '/autologin-user-timeout=/c autologin-user-timeout=0' /etc/lightdm/lightdm.conf
	sed -i '/autologin-session=/c autologin-session=icewm-session' /etc/lightdm/lightdm.conf
	

fi


echo "
########################################################################
############################### REFRACTA ############################### 
########################################################################
"
## Nombre Distro
sed -i "/snapshot_basename=/c snapshot_basename=\"${nombreDistro}\"" /etc/refractasnapshot.conf

##sed -i "/volid=/c volid=\"${nombreDistro}\"" /etc/refractasnapshot.conf 

## Tipo de compresion (Compresion optimizada para CISC (x86))
##sed -i '/mksq_opt="-comp xz -Xbcj x86"/c mksq_opt="-comp xz -Xbcj x86"' /etc/refractasnapshot.conf

## Ajuste limite de CPU
#sed -i '/limit_cpu=/c limit_cpu="yes"' /etc/refractasnapshot.conf
#sed -i '/limit=/c limit="95"' /etc/refractasnapshot.conf

## 
sed -i '/username=/c username="live"' /etc/refractasnapshot.conf

## Archivos y directorios que no se incluiran a la ISO -----------------------------------------------------------------------------------
cp ./refractaSnapshot/snapshot_exclude.list /usr/lib/refractasnapshot/





echo "
########################################################################
################################# GRUB ################################# 
########################################################################
"



## Configura las entredas del menu de GRUB 
sed -i "/Ubuntu|Kubuntu)/c Ubuntu|Kubuntu|${nombreDistro}*)" /etc/grub.d/10_linux

## Copia de seguridad de /etc/default/grub // ¿Necesario? -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
cp ./grub/grub.ucf-dist /etc/default/

## GRUB_CMDLINE_LINUX_DEFAULT="quiet selinux=0" // Invetigar impacto selinux=0 // Revisar splash
#/etc/default/grub

sed -i "/GRUB_DISTRIBUTOR=/c GRUB_DISTRIBUTOR=\`lsb_release -d -s 2> \/dev\/null || echo '${nombreDistro}'\`" /etc/default/grub
#update-grub 



echo "
########################################################################
################################ INIT ################################## 
########################################################################
"

apt install xz-utils

## Configuracion del initramfs
## Debian Vanilla: COMPRESS=zstd || COMPRESS: [ gzip | bzip2 | lz4 | lzma | lzop | xz | zstd ]
sed -i '/COMPRESS=/c COMPRESS=xz' /etc/initramfs-tools/initramfs.conf


# UMASK=0077 significa que los permisos predeterminados para los archivos y directorios creados serán muy restrictivos:
# Archivos: Los permisos serán 600 (solo lectura y escritura para el propietario).
# Directorios: Los permisos serán 700 (lectura, escritura y ejecución solo para el propietario).
echo 'UMASK=0077' > /etc/initramfs-tools/conf.d/calamares-safe-initramfs.conf


## El archivo se utiliza para configurar la reanudación desde la suspensión o hibernación.
if [ -f /etc/initramfs-tools/conf.d/resume ]
then
	rm /etc/initramfs-tools/conf.d/resume
else
	echo "El fichero a eliminar no existe, 
probablemente ya se removio anteriormente, omitiendo este paso..."
fi


echo "
########################################################################
######################### MODULOS DEL KERNEL ########################### 
########################################################################
"
apt -y remove amd64-microcode intel-microcode

##if [ "systemd" == "${init}" ]
##then
	
## Evita que ciertos módulos del kernel del microcodigo del procesador se carguen automáticamente
## AMD 
echo '# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.

## Debian default
blacklist microcode

####################
###### CUSTOM ######
####################
## Controla el altavoz interno de la placa base (también conocido como "buzzer" o "beeper").
blacklist pcspkr
' > /etc/modprobe.d/amd64-microcode-blacklist.conf


## INTEL
echo '# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.

## Debian default
blacklist microcode

####################
###### CUSTOM ######
####################
## Controla el altavoz interno de la placa base (también conocido como "buzzer" o "beeper")
blacklist pcspkr
' > /etc/modprobe.d/intel-microcode-blacklist.conf



##fi




echo "
########################################################################
############################## POLICYKIT ###############################
########################################################################
"
mkdir -p /etc/PolicyKit/

cat << 'EOF' > /etc/PolicyKit/PolicyKit.conf
<?xml version="1.0" encoding="UTF-8"?> <!-- -*- XML -*- -->

<!DOCTYPE pkconfig PUBLIC "-//freedesktop//DTD PolicyKit Configuration 1.0//EN"
"http://hal.freedesktop.org/releases/PolicyKit/1.0/config.dtd">

<!-- See the manual page PolicyKit.conf(5) for file format -->

<config version="0.1">
	<match user="root">
		<return result="yes"/>
	</match>
	<!-- don't ask password for user in live session -->
	<match user="live">
		<return result="yes"/>
	</match>
	<define_admin_auth group="adm"/>
</config>
EOF




echo "
########################################################################
############################### SKEL ###################################
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
############################## HOSTNAME ################################
########################################################################
" 

echo "${nombreDistro}" > /etc/hostname




echo "
########################################################################
######################### AJUSTES USUARIO LIVE #########################
########################################################################
"

####### PRIVILEGIOS
if grep -q "live    ALL=(ALL:ALL) ALL" /etc/sudoers 
then

	echo "Existe ajuste, omitiendo este paso..."
	
else

	sed -i '/root	ALL=(ALL:ALL) ALL/a live    ALL=(ALL:ALL) ALL' /etc/sudoers 

fi





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

























########################################################################






########################################################################






########################################################################






########################################################################





########################################################################


if [ "sysvinit" == "${init}" ]
then

	echo "
	########################################################################
	############################## SYSVINIT ################################
	########################################################################
	"
	
	echo "
	########################################################################
	#################### AJUSTES SCRIPTS ARANQUE ###########################
	########################################################################
	"
	## Gestionar los scripts de inicio de los servicios en sistemas basados en SysVinit. 
	## insserv lee los archivos de configuración de los servicios y asegura que se inicien
	## en el orden correcto, de acuerdo con sus dependencias.
	#apt -y install insserv
		
	## Se elimina la monitoriza los discos duros (SMART)
	insserv -r smartd

	## Se elimina una herramienta de seguridad que restringe las capacidades 
	## de los programas mediante el uso de perfiles de seguridad.
	insserv -r apparmor

	## Se elimina una herramientas para controlar y monitorear discos duros utilizando SMART.
	insserv -r smartmontools
	
	
	
	echo "
	########################################################################
	######################### AJUSTES USUARIO LIVE #########################
	########################################################################
	" 
	
	########## LOGIN SIN CONTRASEÑA (sysVinit)
	## Ajuste al archivo
	##sed -i '/1:2345:respawn:\/sbin\/getty/c 1:2345:respawn:\/sbin\/getty -a live --noclear 38400 tty1' /etc/inittab



	
	

echo "
########################################################################
############################### TTY'S ##################################
########################################################################
"

####### NUM BLOQ ACTIVADO EN TTY'S
if grep -q 'setleds -D +num < $tty' /etc/rc.local
then
	echo 'Existe "setleds -D +num < $tty", omitiendo este paso...'
else
echo '
for tty in /dev/tty[0-9]*; do
        setleds -D +num < $tty
done
' >> /etc/rc.local 

fi


########## Reduciendo numero de tty's (sysVinit)
## Ajuste al archivo
sed -i '/4:23:respawn:\/sbin\/getty/c #4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
sed -i '/5:23:respawn:\/sbin\/getty/c #5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
sed -i '/6:23:respawn:\/sbin\/getty/c #6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab


########## REMOVIENDO SERVICIOS 
update-rc.d -f cron remove


	

echo "
########################################################################
########################## DISPLAY MANAGER #############################
########################################################################
"

## LXDM
apt -y install lxdm 
apt -y install lxdm-loc-os

sed -i '/session=/c session=/usr/bin/icewm-session' /etc/lxdm/default.conf
sed -i '/numlock=/c numlock=1' /etc/lxdm/default.conf



echo "
########################################################################
############################## REFRACTA ################################
########################################################################
"		
## Ajuste sysvinit
sed -i '/patch_init_nosystemd=/c patch_init_nosystemd="yes"' /etc/refractasnapshot.conf



echo "
########################################################################
###############################  GRUB  #################################
########################################################################
"	
fullNameDistro="Loc-OS 23 Linux (Con Tutti)"
sed -i "/GRUB_DISTRIBUTOR=/c GRUB_DISTRIBUTOR=\`lsb_release -d -s 2> \/dev\/null || echo '${fullNameDistro}'\`" /etc/default/grub


#echo "
#########################################################################
######################## MODULOS DEL KERNEL ############################# 
#########################################################################
#"
### ***Todo esta comentado, al instalar paquetes piden regresar el archivo como estaba
### Evita que ciertos módulos del kernel del microcodigo del procesador se carguen automáticamente
### AMD 
#echo '# The microcode module attempts to apply a microcode update when
## it autoloads.  This is not always safe, so we block it by default.

### Debian default
#blacklist microcode

#' > /etc/modprobe.d/amd64-microcode-blacklist.conf


### INTEL
#echo '# The microcode module attempts to apply a microcode update when
## it autoloads.  This is not always safe, so we block it by default.

### Debian default
#blacklist microcode

#' > /etc/modprobe.d/intel-microcode-blacklist.conf

#update-initramfs -u






	
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








fi










update-grub
update-initramfs -u
sudo init q



