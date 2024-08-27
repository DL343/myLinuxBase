#!/bin/bash

## 1. Instalacion de debian base con root:root y live:live

## 2. Preprativos:

##########################################
################## APPS #################
##########################################

apt -y install refractasnapshot-base calamares

##########################################
########### AJUSTES ENTORNO ##############
##########################################
## Establece variables de entorno globales para todos los usuarios del sistema.
echo '

'  tee /etc/environtment


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
" | tee /etc/locale.conf

## Configura el mapa de teclas del sistema para la consola virtual (Las tty's)
echo "KEYMAP=us
" | tee /etc/vconsole.conf

## Configuración de la zona horaria del sistema.
echo "America/New_York" | tee /etc/timezone

## Configuración del teclado en X11.
echo '
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
EndSection
' | tee /etc/X11/xorg.conf.d/00-keyboard.conf

## Afecta cómo se manejan los caracteres y las configuraciones regionales para "live" y "root"
echo "export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8" | tee /home/live/.bashrc

echo "export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8" | tee /root/.bashrc

## Son configuraciones de idioma y codificación de caracteres.
echo "en_US.UTF-8 UTF-8
C.UTF-8 UTF-8" | tee /etc/locale.gen
locale-gen

#########################################
############## REFRACTA #################
#########################################

## Nombre Distro
sed -i 's/snapshot_basename="snapshot"/snapshot_basename="nombreDistro"/' /etc/refractasnapshot.conf
sed -i 's/volid="liveiso"/volid="nombreDistro"/' /etc/refractasnapshot.conf 

## Tipo de compresion (Compresion optimizada para CISC (x86))
sed -i 's/#mksq_opt="-comp xz -Xbcj x86"/mksq_opt="-comp xz -Xbcj x86"/' /etc/refractasnapshot.conf 

## Para distros sin systemd
#sed -i 's/#patch_init_nosystemd="yes"/patch_init_nosystemd="yes"/' /etc/refractasnapshot.conf




##########################################

## Imagen Arranque Instalacion 
cp ./imagenBootloader.png /usr/lib/refractasnapshot/iso/isolinux/splash.png

##########################################

## Archivos y directorios a excluir
#/usr/lib/refractasnapshot/snapshot_exclude.list
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
## Lineas a añadir
: "
## Custom
- /root/*
- /home/*/.config/htop
- /home/*/.config/session/*
- /home/*/.config/gwenviewrc
- /home/*/.local/share/RecentDocuments/* 
"

apt -y remove amd64-microcode intel-microcode

###########################################
################# GRUB ####################
###########################################
## GRUB_CMDLINE_LINUX_DEFAULT="quiet selinux=0" // Invetigar impacto selinux=0
#/etc/default/grub


## Copia de seguridad de /etc/default/grub // ¿Necesario?
cp ./grub.ucf-dist /etc/default/


## Configurar la disposición del teclado en el sistema
echo '
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
' | tee /etc/default/keyboard


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
"|  tee /etc/default/locale


##
sed -i 's/Ubuntu|Kubuntu)/Ubuntu|Kubuntu|nombreDistro*)/' /etc/grub.d/10_linux
update-grub


##############################
########## INIT ##############
##############################
## Configuracion del initramfs
#/etc/initramfs-tools/initramfs.conf
## Debian: COMPRESS=zstd
## # COMPRESS: [ gzip | bzip2 | lz4 | lzma | lzop | xz | zstd ]
## COMPRESS=xz



# UMASK=0077 significa que los permisos predeterminados para los archivos y directorios creados serán muy restrictivos:
# Archivos: Los permisos serán 600 (solo lectura y escritura para el propietario).
# Directorios: Los permisos serán 700 (lectura, escritura y ejecución solo para el propietario).
echo '
UMASK=0077
' |  tee /etc/initramfs-tools/conf.d/calamares-safe-initramfs.conf




## El archivo se utiliza para configurar la reanudación desde la suspensión o hibernación.
rm /etc/initramfs-tools/conf.d/resume


## Evita que ciertos módulos del kernel, que podrían estar relacionados con el microcódigo de AMD e Intel, se carguen automáticamente
echo '
# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.
blacklist microcode

## Controla el altavoz interno de la placa base (también conocido como "buzzer" o "beeper").
blacklist pcspkr
' |  tee /etc/modprobe.d/amd64-microcode-blacklist.conf


echo '
# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.
blacklist microcode

## Controla el altavoz interno de la placa base (también conocido como "buzzer" o "beeper")
blacklist pcspkr
' |  tee /etc/modprobe.d/intel-microcode-blacklist.conf

update-initramfs -u


######################################
########### POLICYKIT ################
######################################
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
' |  tee /etc/PolicyKit/PolicyKit.conf
 



reboot



