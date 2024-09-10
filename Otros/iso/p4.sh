#!/usr/bin/env bash

source ./variables.sh

############################################################
#################### APPS NECESARIAS ####################### 
############################################################

## Calamares 
apt -y install calamares 

if [ "systemd" == "${init}" ]
then
	apt -y calamares-settings-debian network-manager-gnome

fi

## Refractasnapshot
apt -y install ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb 


## LiveTools
apt -y install live-boot live-config-doc  live-config live-tools live-boot-initramfs-tools

## ISO Tools
apt -y install xorriso genisoimage squashfs-tools

## GVFS
apt -y install gvfs-common gvfs-daemons gvfs-libs gvfs

## SYSLinux
apt -y install syslinux syslinux-common

## Grub
apt -y install grub-efi grub-pc-bin

## GNUStep
apt -y install gnustep-base-common gnustep-base-runtime gnustep-common

## Polkit
apt -y install policykit-1 polkitd-pkla p11-kit

## Firmwares
apt -y install firmware-atheros firmware-b43-installer firmware-brcm80211 firmware-iwlwifi firmware-libertas firmware-linux-nonfree firmware-linux firmware-misc-nonfree firmware-qlogic firmware-realtek-rtl8723cs-bt firmware-realtek firmware-samsung

## Misc. Tools
apt -y install xorg zenity xapps-common uno-libs-private toilet tree unar caca-utils acl btrfs-progs cryptsetup gcr  gparted lynx mtools ntpsec user-setup yad libduktape207 mlocate keyutils
## 



## Misc. Tools
apt -y install xorg   
apt -y install icewm --no-install-recommends 
apt -y install lightdm lightdm-gtk-greeter nitrogen
apt -y install xz-utils 


#mlocate ## Herramienta para la búsqueda rápida de archivos en el sistema, basada en una base de datos.
#user-setup ## Herramienta para la configuración y gestión de usuarios en un sistema.
#ntpsec ## Implementación segura del Protocolo de Tiempo de Red (NTP) para sincronizar relojes de sistemas.



#zenity ##Herramienta para crear diálogos gráficos simples desde la línea de comandos.
#xapps-common ## Paquete que contiene archivos comunes para las aplicaciones de Xfce, un entorno de escritorio ligero.
#uno-libs-private ## Librerías privadas usadas por aplicaciones que utilizan el framework UNO, común en LibreOffice.
#toilet ## Una herramienta para crear texto ASCII art en la terminal.
#tree ## Muestra la estructura de directorios en forma de árbol.
#caca-utils ## Utilidades relacionadas con la biblioteca libcaca para generar arte ASCII en la terminal.
#acl ## Implementa listas de control de acceso (Access Control Lists) para un manejo más fino de permisos de archivos.
#lynx ## Navegador web en modo texto.
#yad ## Herramienta similar a Zenity, que permite crear diálogos gráficos desde la línea de comandos.
#libduktape207 ## Biblioteca para el motor de JavaScript Duktape, versión 2.07.

## Disponible para sysvinit? 
#glpkg ## Gestión de paquetes para GLPK, una biblioteca para programación lineal y combinatoria.







###########################################################
################# AJUSTES GENERALES  ###################### 
############################################################
## Establece variables de entorno globales.
echo 'QT_QPA_PLATFORMTHEME=gtk2' > /etc/environtment


## Configuracion generica (puede ser encontrado en diferentes distros)
## LANG: Define el idioma y la localización
## LC_*: Configuran aspectos específicos (localización, fecha, hora, numeros, etc.).
echo "
LANG=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_TIME=en_US.UTF-8
" > /etc/locale.conf
## LC_ALL=en_US.UTF-8
## LANGUAGE=en_US.UTF-8



## Distribucion de teclado para las tty's
echo "KEYMAP=us" > /etc/vconsole.conf



## Zona horaria
echo "America/New_York" > /etc/timezone



## Distribucion de teclado en X11.
echo '
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
EndSection
' > /etc/X11/xorg.conf.d/00-keyboard.conf


## Configurar la disposición del teclado en el sistema
echo '
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
' > /etc/default/keyboard


## Configuracion especifica que utiliza Debian
## LANG: Define el idioma y la localización
## LC_*: Configuran aspectos específicos (localización,fecha, hora, numeros, etc.).
echo "
LANG=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_TIME=en_US.UTF-8
" > /etc/default/locale


## Afecta cómo se manejan los caracteres y las configuraciones regionales para "live" y "root"
##echo "export LC_CTYPE=en_US.UTF-8
##export LC_ALL=en_US.UTF-8" > /home/live/.bashrc

##echo "export LC_CTYPE=en_US.UTF-8
##export LC_ALL=en_US.UTF-8" > /root/.bashrc

## Define qué configuraciones regionales estarán disponibles en el sistema. 
##echo "en_US.UTF-8 UTF-8
##C.UTF-8 UTF-8" > /etc/locale.gen

locale-gen

##########################################################
######################## REFRACTA ######################## 
##########################################################

## Nombre Distro
sed -i "/snapshot_basename=\"snapshot\"/c snapshot_basename=\"${nombreDistro}\"" /etc/refractasnapshot.conf

##sed -i "/volid=\"liveiso\"/c volid=\"${nombreDistro}\"" /etc/refractasnapshot.conf 

## Tipo de compresion (Compresion optimizada para CISC (x86))
sed -i '/#mksq_opt="-comp xz -Xbcj x86"/c mksq_opt="-comp xz -Xbcj x86"/' /etc/refractasnapshot.conf

sed -i '/limit=/c limit="90"' /etc/refractasnapshot.conf

sed -i '/#username=/c username="live"' /etc/refractasnapshot.conf

## Archivos y directorios que no se incluiran a la ISO -----------------------------------------------------------------------------------
cp ./refractaSnapshot/snapshot_exclude.list /usr/lib/refractasnapshot/

if [ "systemd" == "${init}" ]
then
	
	## Imagen Arranque Instalacion (640x480).png (Colores oscuros de preferencia)--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#cp ./imagenBootloader.png /usr/lib/refractasnapshot/iso/isolinux/splash.png

	
fi



########################################################
######################## GRUB ######################### 
########################################################

## Configura las entredas del menu de GRUB 
sed -i "s/Ubuntu|Kubuntu)/Ubuntu|Kubuntu|${nombreDistro}*)/" /etc/grub.d/10_linux

## Copia de seguridad de /etc/default/grub // ¿Necesario? -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
cp ./grub/grub.ucf-dist /etc/default/

## GRUB_CMDLINE_LINUX_DEFAULT="quiet selinux=0" // Invetigar impacto selinux=0 // Revisar splash
#/etc/default/grub

update-grub


########################################################
######################## INIT ######################### 
########################################################
## Configuracion del initramfs
## Debian Vanilla: COMPRESS=zstd || COMPRESS: [ gzip | bzip2 | lz4 | lzma | lzop | xz | zstd ]
sed -i '/COMPRESS=/c COMPRESS=xz' /etc/initramfs-tools/initramfs.conf


# UMASK=0077 significa que los permisos predeterminados para los archivos y directorios creados serán muy restrictivos:
# Archivos: Los permisos serán 600 (solo lectura y escritura para el propietario).
# Directorios: Los permisos serán 700 (lectura, escritura y ejecución solo para el propietario).
echo 'UMASK=0077' > /etc/initramfs-tools/conf.d/calamares-safe-initramfs.conf


## El archivo se utiliza para configurar la reanudación desde la suspensión o hibernación.
rm /etc/initramfs-tools/conf.d/resume




########################################################
################ MODULOS DEL KERNEL ################### 
########################################################

apt -y remove amd64-microcode intel-microcode

if [ "systemd" == "${init}" ]
then
	
## Evita que ciertos módulos del kernel del microcodigo del procesador se carguen automáticamente
## AMD 
echo '
# The microcode module attempts to apply a microcode update when
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
echo '
# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.

## Debian default
blacklist microcode

####################
###### CUSTOM ######
####################
## Controla el altavoz interno de la placa base (también conocido como "buzzer" o "beeper")
blacklist pcspkr
' > /etc/modprobe.d/intel-microcode-blacklist.conf

fi


update-initramfs -u


########################################################
##################### POLICYKIT #######################
########################################################
mkdir -p /etc/PolicyKit/

cp ./policyKit/PolicyKit.conf /etc/PolicyKit/

reboot










########################################################################
############################# ¿SYSVINIT? ###############################
########################################################################
if [ "sysvinit" == "${init}" ]
then
	
	## Configuraciones de calamares
	echo "calamares-settings para sysvinit"
	apt -y install calamares-settings-loc-os 
	apt -y install live-config-sysvinit 
	apt -y install glpkg 


## REFRACTA
	## Ajuste sysvinit
	sed -i '/#patch_init_nosystemd="yes"/c patch_init_nosystemd="yes"' /etc/refractasnapshot.conf
	
	## Imagen arranque	
	cp ./LO/splash.png /usr/lib/refractasnapshot/iso/isolinux/splash.png
	
## GRUB
	## Configuracion
	cp ./LO/grub /etc/default/grub
	
	
	
	
	
	## Tema GRUB
	mkdir -p /boot/grub/themes/Loc-OS/
	cp ./LO/grub_theme/* /boot/grub/themes/Loc-OS/
	
	update-grub

    ## Connman
	apt -y install connman connman-gtk
	apt -y purge network-manager
	
	#### Apariencia
	## Wallpapers
	 cp ./LO/wallpapers/* /usr/share/wallpapers/
	
	## Colores
	## /usr/share/color-schemes/
	
	## Iconos
	cp -r ./LO/icons/* /usr/share/icons/
	
	## Cursor
	
	
	## Icono usuario
	cp ./LO/face.png /etc/skel/.face

	## Neofetch
	#mkdir -p /etc/skel/.config/neofetch
	#mkdir -p /home/live/.config/neofetch
	#cp ./LO/neofetch.conf /etc/skel/.config/neofetch/config.conf
	#cp ./LO/neofetch.conf /home/live/.config/neofetch/config.conf
	

fi

