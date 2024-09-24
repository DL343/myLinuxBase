#!/usr/bin/env bash

source ./variables.sh

dhclient


if [ "sysvinit" == "${init}" ]
then
	echo "
	############################################################
	################## LIMPIEZA DE SYSTEMD #################### 
	############################################################
	"
	apt -y purge *systemd*  
	update-grub
	
fi

echo "
############################################################
############ AJUSTE ESTANDAR DE REPOSITORIOS ###############
############################################################
"
cp ./apt/sources.list /etc/apt/

cp ./apt/sources-final /sbin/

cp ./apt/sources-media /sbin/

apt update



echo "
########################################################################
################# AJUSTES REGION, IDIOMA, TECLADO...  ##################
########################################################################
"
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
cp ./locale/locale.gen /etc/locale.gen

locale-gen

#reboot
