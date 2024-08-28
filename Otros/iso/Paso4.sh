#!/usr/bin/env bash

set -e

nombreDistro=Prueba001


## 1. Instalacion de debian base con root:root y live:live
## 2. Modificaciones profundas (init(libudev1), 		repositorios, 		/etc/lsb-release, 		Kernel)
## 3. Auxiliar(Limpiar restos de systemd si es que se elimino), 			Se instala ENV/WM			Algo con los repositorios:
## /etc/apt/sources.list
## /sbin/sources-final
## /sbin/sources-media
## 4. Preparativos:


############################################################
########################## APPS ############################ 
############################################################


## Calamares y Refractasnapshot
apt -y install refractasnapshot-base calamares 
## calamares-settings-loc-os

## LiveTools
apt -y install live-boot live-config-doc live-config-sysvinit live-config live-tools live-boot-initramfs-tools

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
apt -y install xorg 

gparted ## Interfaz gráfica para la gestión de particiones de disco.
btrfs-progs ## Herramientas para manejar el sistema de archivos Btrfs.
mtools ## Conjunto de herramientas para manipular disquetes (especialmente FAT).
cryptsetup ## Herramienta para gestionar el cifrado de discos y particiones usando LUKS.
gcr ## Biblioteca para manejar certificados y claves, usada en aplicaciones de seguridad.
unar ## Utilidad para descomprimir archivos en varios formatos, como RAR y ZIP.
keyutils ## Utilidades para gestionar claves y conjuntos de claves en el kernel de Linux.

mlocate ## Herramienta para la búsqueda rápida de archivos en el sistema, basada en una base de datos.
user-setup ## Herramienta para la configuración y gestión de usuarios en un sistema.
ntpsec ## Implementación segura del Protocolo de Tiempo de Red (NTP) para sincronizar relojes de sistemas.



zenity ##Herramienta para crear diálogos gráficos simples desde la línea de comandos.
xapps-common ## Paquete que contiene archivos comunes para las aplicaciones de Xfce, un entorno de escritorio ligero.
uno-libs-private ## Librerías privadas usadas por aplicaciones que utilizan el framework UNO, común en LibreOffice.
toilet ## Una herramienta para crear texto ASCII art en la terminal.
tree ## Muestra la estructura de directorios en forma de árbol.
caca-utils ## Utilidades relacionadas con la biblioteca libcaca para generar arte ASCII en la terminal.
acl ## Implementa listas de control de acceso (Access Control Lists) para un manejo más fino de permisos de archivos.
glpkg ## Gestión de paquetes para GLPK, una biblioteca para programación lineal y combinatoria.
lynx ## Navegador web en modo texto.
yad ## Herramienta similar a Zenity, que permite crear diálogos gráficos desde la línea de comandos.
libduktape207 ## Biblioteca para el motor de JavaScript Duktape, versión 2.07.






############################################################
##################### AJUSTES ENTORNO ###################### 
############################################################
## Establece variables de entorno globales para todos los usuarios del sistema.
#echo '
#
#' > /etc/environtment


## Configura las variables de entorno relacionadas con la localizació, idioma, etc. del sistema
echo "
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_TIME=en_US.UTF-8
LANGUAGE=en_US.UTF-8
" > /etc/locale.conf

## Configura el mapa de teclas del sistema para la consola virtual (Las tty's)
echo "KEYMAP=us
" > /etc/vconsole.conf

## Configuración de la zona horaria del sistema.
echo "America/New_York" > /etc/timezone

## Configuración del teclado en X11.
echo '
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
EndSection
' > /etc/X11/xorg.conf.d/00-keyboard.conf

## Afecta cómo se manejan los caracteres y las configuraciones regionales para "live" y "root"
echo "export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8" > /home/live/.bashrc

echo "export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8" > /root/.bashrc

## Son configuraciones de idioma y codificación de caracteres.
echo "en_US.UTF-8 UTF-8
C.UTF-8 UTF-8" > /etc/locale.gen
locale-gen

##########################################################
######################## REFRACTA ######################## 
##########################################################

## Nombre Distro
sed -i "s/snapshot_basename=\"snapshot\"/snapshot_basename=\"${nombreDistro}\"/" /etc/refractasnapshot.conf

sed -i "s/volid=\"liveiso\"/volid=\"${nombreDistro}\"/" /etc/refractasnapshot.conf 

## Tipo de compresion (Compresion optimizada para CISC (x86))
sed -i 's/#mksq_opt="-comp xz -Xbcj x86"/mksq_opt="-comp xz -Xbcj x86"/' /etc/refractasnapshot.conf 

## Para distros sin systemd
#sed -i 's/#patch_init_nosystemd="yes"/patch_init_nosystemd="yes"/' /etc/refractasnapshot.conf




##########################################

## Imagen Arranque Instalacion?--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cp ./imagenBootloader.png /usr/lib/refractasnapshot/iso/isolinux/splash.png

##########################################

## Archivos y directorios que no se incluiran a la ISO
function excluRefracta {
	
echo "
# rsync excludes file for refractasnapshot and refractasnapshot-gui
# version 9.3.4


# Exclude some system files. These are required, and you probably 
# shouldn't change them.

- /dev/*
- /cdrom/*
- /media/*
- /swapfile
- /mnt/*
- /sys/*
- /proc/*
- /tmp/*
- /live
- /persistence.conf
- /boot/grub/grub.cfg
- /boot/grub/menu.lst
- /boot/grub/device.map
- /boot/*.bak
- /boot/*.old-dkms
- /etc/udev/rules.d/70-persistent-cd.rules
- /etc/udev/rules.d/70-persistent-net.rules
- /etc/fstab
- /etc/fstab.d/*
- /etc/mtab
- /etc/blkid.tab
- /etc/blkid.tab.old
- /etc/apt/sources.list~
- /etc/crypttab
- /etc/initramfs-tools/conf.d/resume     # see remove-cryptroot and nocrypt.sh
- /etc/initramfs-tools/conf.d/cryptroot  # see remove-cryptroot and nocrypt.sh
- /etc/popularity-contest.conf
- /home/snapshot

# Added for newer version of live-config/live-boot in wheezy 
# These are only relevant here if you create a snapshot while
# you're running a live-CD or live-usb. 
- /lib/live/overlay
- /lib/live/image
- /lib/live/rootfs
- /lib/live/mount
- /run/*

# Added for symlink /lib
- /usr/lib/live/overlay
- /usr/lib/live/image
- /usr/lib/live/rootfs
- /usr/lib/live/mount

## Entries below are optional. They are included either for privacy
## or to reduce the size of the snapshot. If you have any large
## files or directories, you should exclude them from being copied
## by adding them to this list.
##
## Entries beginning with /home/*/ will affect all users.


# Uncomment this to exclude everything in /var/log/
#- /var/log/*

# As of version 9.2.0, current log files are truncated,
# and archived log files are excluded.
#
# The next three lines exclude everything in /var/log
# except /var/log/clamav/ (or anything else beginning with "c") and
# /var/log/gdm (or anything beginning with "g").
# If clamav log files are excluded, freshclam will give errors at boot.
- /var/log/[a-b,A-Z]*
- /var/log/[d-f]*
- /var/log/[h-z]*
- /var/log/*gz

- /var/cache/apt/archives/*.deb
- /var/cache/apt/pkgcache.bin
- /var/cache/apt/srcpkgcache.bin
- /var/cache/apt/apt-file/*
- /var/cache/debconf/*~old
- /var/lib/apt/lists/*
- /var/lib/apt/*~
- /var/lib/apt/cdroms.list
- /var/lib/aptitude/*.old
- /var/lib/dhcp/*
- /var/lib/dpkg/*~old
- /var/spool/mail/*
- /var/mail/*
- /var/backups/*.gz
- /var/backups/*.bak
- /var/lib/dbus/machine-id
- /var/lib/live/config/*

- /usr/share/icons/*/icon-theme.cache

- /root/.aptitude
- /root/.bash_history
- /root/.disk-manager.conf
- /root/.fstab.log
- /root/.lesshst
- /root/*/.log
- /root/.local/share/*
- /root/.nano_history
- /root/.synaptic
- /root/.VirtualBox
- /root/.ICEauthority
- /root/.Xauthority


- /root/.ssh

- /home/*/.Trash*
- /home/*/.local/share/Trash/*
- /home/*/.mozilla/*/Cache/*
- /home/*/.mozilla/*/urlclassifier3.sqlite
- /home/*/.mozilla/*/places.sqlite
- /home/*/.mozilla/*/cookies.sqlite
- /home/*/.mozilla/*/signons.sqlite
- /home/*/.mozilla/*/formhistory.sqlite
- /home/*/.mozilla/*/downloads.sqlite
- /home/*/.adobe
- /home/*/.aptitude
- /home/*/.bash_history
- /home/*/.cache
- /home/*/.dbus
- /home/*/.gksu*
- /home/*/.gvfs
- /home/*/.lesshst
- /home/*/.log
- /home/*/.macromedia
- /home/*/.nano_history
- /home/*/.pulse*
- /home/*/.recently-used
- /home/*/.recently-used.xbel
- /home/*/.local/share/recently-used.xbel
- /home/*/.thumbnails/large/*
- /home/*/.thumbnails/normal/*
- /home/*/.thumbnails/fail/*
- /home/*/.vbox*
- /home/*/.VirtualBox
- /home/*/VirtualBox\ VMs
- /home/*/.wine
- /home/*/.xsession-errors*
- /home/*/.ICEauthority
- /home/*/.Xauthority

# You might want to comment these out if you're making a snapshot for
# your own personal use, not to be shared with others.
- /home/*/.gnupg
- /home/*/.ssh
- /home/*/.xchat2
- /home/*/.config/hexchat

# Exclude ssh_host_keys. New ones will be generated upon live boot.
# This fixes a security hole in all versions before 9.0.9-3.
# If you really want to clone your existing ssh host keys
# in your snapshot, comment out these two lines.
- /etc/ssh/ssh_host_*_key*
- /etc/ssh/ssh_host_key*

# Examples of things to exclude in order to keep the image small:
- /home/*/Downloads/*
- /home/*/Music/*
- /home/user/Pictures/*
- /home/*/Videos/*


# To exclude all hidden files and directories in your home, uncomment
# the next line. You will lose custom desktop configs if you do.
#- /home/*/.[a-z,A-Z,0-9]*


#################
###  Custom  ####
#################
- /root/*
- /home/*/.config/htop
- /home/*/.config/session/*
- /home/*/.config/kmixrc

- /home/*/.local/share/RecentDocuments/*

" > /usr/lib/refractasnapshot/snapshot_exclude.list
	
}

excluRefracta


## Lineas a descomentar
: "
- /var/log/[a-b,A-Z]*
- /var/log/[d-f]*
- /var/log/[h-z]*
- /var/log/*gz

- /var/backups/*.bak

- /home/*/.wine

- /home/*/Downloads/*
- /home/*/Music/*
- /home/*/Pictures/*
- /home/*/Videos/*

"
## Lineas a añadir ????
: "
## Custom
- /root/*
- /home/*/.config/htop
- /home/*/.config/kate
- /home/*/.config/session/*
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
- /home/*/.local/share/RecentDocuments/*
"

apt -y remove amd64-microcode intel-microcode


########################################################
######################## GRUB ######################### 
########################################################
## GRUB_CMDLINE_LINUX_DEFAULT="quiet selinux=0" // Invetigar impacto selinux=0 // Revisar splash
#/etc/default/grub


## Copia de seguridad de /etc/default/grub // ¿Necesario? -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
function grubUcf {
echo '
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=0
GRUB_TIMEOUT=3
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX=""

# If your computer has multiple operating systems installed, then you
# probably want to run os-prober. However, if your computer is a host
# for guest OSes installed via LVM or raw disk devices, running
# os-prober can cause damage to those guest OSes as it mounts
# filesystems to look for things.
#GRUB_DISABLE_OS_PROBER=false

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal
#GRUB_TERMINAL=console

# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command "vbeinfo"
#GRUB_GFXMODE=640x480

# Uncomment if you dont want GRUB to pass "root=UUID=xxx" parameter to Linux
#GRUB_DISABLE_LINUX_UUID=true

# Uncomment to disable generation of recovery mode menu entries
#GRUB_DISABLE_RECOVERY="true"

# Uncomment to get a beep at grub start
#GRUB_INIT_TUNE="480 440 1"

' > /etc/default/grub.ucf-dist

}

grubUcf


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


## Variables determinan la configuración regional que afecta
## cómo se muestran las fechas, los números, los formatos de moneda y el idioma en general.
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


## Configura las entredas del menu de GRUB 
sed -i "s/Ubuntu|Kubuntu)/Ubuntu|Kubuntu|${nombreDistro}*)/" /etc/grub.d/10_linux

update-grub


########################################################
######################## INIT ######################### 
########################################################
## Configuracion del initramfs
## Debian Vanilla: COMPRESS=zstd || COMPRESS: [ gzip | bzip2 | lz4 | lzma | lzop | xz | zstd ]
sed -i '/COMPRESS=/cCOMPRESS=xz' /etc/initramfs-tools/initramfs.conf


# UMASK=0077 significa que los permisos predeterminados para los archivos y directorios creados serán muy restrictivos:
# Archivos: Los permisos serán 600 (solo lectura y escritura para el propietario).
# Directorios: Los permisos serán 700 (lectura, escritura y ejecución solo para el propietario).
echo 'UMASK=0077' > /etc/initramfs-tools/conf.d/calamares-safe-initramfs.conf


## El archivo se utiliza para configurar la reanudación desde la suspensión o hibernación.
rm /etc/initramfs-tools/conf.d/resume


## Evita que ciertos módulos del kernel del microcodigo del procesador se carguen automáticamente
## AMD 
echo '
# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.
blacklist microcode

## Controla el altavoz interno de la placa base (también conocido como "buzzer" o "beeper").
blacklist pcspkr
' > /etc/modprobe.d/amd64-microcode-blacklist.conf


## INTEL
echo '
# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.
blacklist microcode

## Controla el altavoz interno de la placa base (también conocido como "buzzer" o "beeper")
blacklist pcspkr
' > /etc/modprobe.d/intel-microcode-blacklist.conf

update-initramfs -u


########################################################
##################### POLICYKIT #######################
########################################################
echo '
<?xml version="1.0" encoding="UTF-8"?> <!-- -*- XML -*- -->

<!DOCTYPE pkconfig PUBLIC "-//freedesktop//DTD PolicyKit Configuration 1.0//EN"
"http://hal.freedesktop.org/releases/PolicyKit/1.0/config.dtd">

<!-- See the manual page PolicyKit.conf(5) for file format -->

<config version="0.1">
	<match user="root">
		<return result="yes"/>
	</match>
	<!-- don`t ask password for user in live session -->
	<match user="live">
		<return result="yes"/>
	</match>
	<define_admin_auth group="adm"/>
</config>
' > /etc/PolicyKit/PolicyKit.conf
 



reboot



