#!/usr/bin/env bash

source ./variables.sh



echo "
########################################################################
############################ APPS NECESARIAS ########################### 
########################################################################
"



if [ "systemd" == "${init}" ]
then
	
	echo ":: calamares para systemd"
	apt -y install ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb calamares calamares-settings-debian live-config-systemd 
		
		
else 
	
	echo ":: calamares para sysvinit"
	apt -y install ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb calamares calamares-settings-loc-os live-config-sysvinit
	
	apt -y install glpkg

fi


## LiveTools
apt -y install live-boot live-config-doc live-config live-tools live-boot-initramfs-tools


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


apt -y install xz-utils nitrogen 
apt -y install connman connman-gtk

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






echo "
########################################################################
############################### REFRACTA ############################### 
########################################################################
"
## Nombre Distro
sed -i "/snapshot_basename=\"snapshot\"/c snapshot_basename=\"${nombreDistro}\"" /etc/refractasnapshot.conf

##sed -i "/volid=/c volid=\"${nombreDistro}\"" /etc/refractasnapshot.conf 

## Tipo de compresion (Compresion optimizada para CISC (x86))
##sed -i '/mksq_opt="-comp xz -Xbcj x86"/c mksq_opt="-comp xz -Xbcj x86"' /etc/refractasnapshot.conf

## Ajuste limite de CPU
sed -i '/limit_cpu=/c limit_cpu="yes"' /etc/refractasnapshot.conf
sed -i '/limit=/c limit="95"' /etc/refractasnapshot.conf

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

update-grub

echo "
########################################################################
################################ INIT ################################## 
########################################################################
"
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

if [ "systemd" == "${init}" ]
then
	
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

update-initramfs -u

fi




echo "
########################################################################
############################## POLICYKIT ###############################
########################################################################
"
mkdir -p /etc/PolicyKit/

cp ./policyKit/PolicyKit.conf /etc/PolicyKit/











if [ "sysvinit" == "${init}" ]
then

	echo "
	########################################################################
	############################## SYSVINIT ################################
	########################################################################
	"
	
	###### Paquetes de configuraciones de calamares ***Se movio hasta arriba que se necesitan 

	
	
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
	#update-grub 
	
	
	
	echo "
	########################################################################
	####################### MODULOS DEL KERNEL ############################# 
	########################################################################
	"
	## ***Todo esta comentado, al instalar paquetes piden regresar el archivo como estaba
	## Evita que ciertos módulos del kernel del microcodigo del procesador se carguen automáticamente
	## AMD 
	echo '# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.

## Debian default
blacklist microcode

' > /etc/modprobe.d/amd64-microcode-blacklist.conf


	## INTEL
	echo '# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.

## Debian default
blacklist microcode

' > /etc/modprobe.d/intel-microcode-blacklist.conf
		
	update-initramfs -u
		

fi



#reboot
