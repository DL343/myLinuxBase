#!/usr/bin/env bash


nombreDistro=Prueba001


## 1. Instalacion de debian base con root:root y live:live
## 2. Modificaciones profundas (init(libudev1), 		repositorios, 		/etc/lsb-release, 		Kernel)
## 3. Auxiliar(Limpiar restos de systemd si es que se elimino), 			Se instala ENV/WM			Algo con los repositorios:
## 4. Preparativos:


############################################################
########################## APPS ############################ 
############################################################


## Calamares (COn su respectivo modulo de configuracion)
apt -y install calamares calamares-settings-debian
## calamares-settings-loc-os 

## Refractasnapshot
apt -y install ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb 
## refractasnapshot-base 

## LiveTools
apt -y install live-boot live-config-doc  live-config live-tools live-boot-initramfs-tools
## live-config-sysvinit ## Para sysVinit

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
##apt -y install xorg zenity xapps-common uno-libs-private toilet tree unar caca-utils acl btrfs-progs cryptsetup gcr glpkg  gparted lynx mtools ntpsec user-setup yad libduktape207 mlocate keyutils

























## Misc. Tools
apt -y install xorg 
apt -y install icewm --no-install-recommends 
apt -y install lightdm lightdm-gtk-greeter
apt -y install smartmontools 


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

## Imagen Arranque Instalacion ¿tamaño?--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#cp ./imagenBootloader.png /usr/lib/refractasnapshot/iso/isolinux/splash.png

##########################################

## Archivos y directorios que no se incluiran a la ISO -----------------------------------------------------------------------------------
cp ./refractaSnapshot/snapshot_exclude.list /usr/lib/refractasnapshot/
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
cp ./grub/grub.ucf-dist /etc/default/

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
mkdir -p /etc/PolicyKit/

cp ./policyKit/PolicyKit.conf /etc/PolicyKit/


reboot



