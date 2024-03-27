#!/bin/bash

###################################
#			DEBLOAT
###################################
## De forma centralizada registra los registros del sistema y servicios
sudo systemctl mask systemd-journald.service 

## ??????????????????'
sudo systemctl mask avahi-daemon.service 

## Es responsable de la recopilación de datos de uso de recursos del sistema, como la CPU, la memoria, el disco y la red, para su posterior análisis y generación de informes.
##atop
##  |----> atopacctd
sudo systemctl mask atop
sudo systemctl mask atopacct.service 

## Registra los mensajes del sistema
sudo systemctl mask rsyslog.service 

## Es un servicio de programación de tareas
sudo systemctl disable cron
sudo systemctl disable anacron.service 

## es el componente del sistema que gestiona las conexiones SSH entrantes y salientes en el servidor.
sudo systemctl mask sshd

## proporciona la funcionalidad del Bluetooth
sudo systemctl mask bluetooth.service

## Gestion de paquetes de software
sudo systemctl mask packagekit.service 

## Entropia adicional / Generacion de numeros, Criptografia, seguridad
sudo systemctl mask haveged
sudo systemctl mask rng-tools
sudo systemctl mask rng-tools-debian.service

## Monotoriza y registra el trafico de red
sudo systemctl mask vnstat.service 

## Acceso y transferecias de archivos de sistemas remotos de forma segura
sudo systemctl mask ssh.service 
systemctl --user mask ssh-agent.service 

## Gestiona la bateria y energia
sudo systemctl mask upower.service

## Soporte para la accesibilidad / asistencia
systemctl --user mask at-spi-dbus-bus.service 

## Soporte para impresoras
sudo systemctl mask cups.service 

## Soporte empresarial de Ubuntu Pro, soporte tecnico
sudo systemctl disable ubuntu-advantage.service 

## Es un servicio de llamadas a procedimientos remotos
sudo systemctl mask rpcbind.service 

## Actualizaciones desatendidas
sudo systemctl mask unattended-upgrades.service 



################################################

## Mantiene el reloj del sistema sincronizado con un servidor de tiempo de red, lo que asegura que la hora del sistema sea precisa y esté actualizada.
#systemd-timesyncd

##  Su función principal es proporcionar una forma de configurar la red de forma dinámica y flexible, reemplazando a los tradicionales sistemas de configuración de red como "ifupdown" en sistemas Debian o "network" en sistemas Red Hat.
#systemcd-networkd

## Proporciona una resolución de DNS eficiente y flexible, así como una gestión avanzada de la configuración de DNS.
#systemd-resolved

## Administrar los dispositivos en el sistema, incluyendo la detección, creación y gestión dinámica de los nodos de dispositivo en el directorio /dev.
#systemd-udevd

## Gestion robusta y automatizada de los dispositivos de almacenamiento y mejorando la disponibilidad, el rendimiento y la tolerancia a fallos del sistema.
#multipathd

## Gestion centralizada de la configuracion del escritorio
#dconf-service

## Gestion centralizada de contraseñas y claves de forma segura
#gnome-keyring-daemon

## Administrar las sesiones de usuario, controlar el acceso a los recursos del sistema y gestionar las políticas de inicio de sesión en el sistema.
#systemd-logind

## fwupd (Firmware Update) 
## permite a los usuarios mantener actualizados los microcódigos, firmware y BIOS de diversos dispositivos de hardware en sus sistemas Linux, como placas base, tarjetas de red, unidades SSD, teclados, ratones y otros periféricos compatibles.
#fwupd

## es un agente para la gestión de claves y la realización de operaciones criptográficas en el sistema.
#gpg-agent

## Sincronizacion del reloj preciso
#chronyd


## ?????????????????????
# hwrng





##################################
#        APPS INNECESARIAS
##################################

remove=$("sudo apt remove")

echo "## Intalador de paquetes facil y grafico" 
$remove packagekit 

echo "## Actualizador de paquetes facil y grafico"
$remove update-manager

## Thunderbird
$remove thunderbird

## Intercepta crasheos de primera vez
$remove apport

## Reporte de errores ubuntu
$remove whoopsie

## Reporte de hardware
$remove ubuntu-report 

## Multiples servicios
$remove evolution-data-server-common 

## Terminales
$remove terminator xfce4-terminal 





##################################
#        APPS NECESARIAS
##################################
echo "## Actualizacion completa"
sudo apt update
sudo apt upgrade -y

echo "## Preload"
sudo apt install preload -y
sudo systemctl enable preload.service

echo "## Preload"
sudo apt install tlp -y
sudo systemctl enable tlp.service

echo "## Brave" 
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

echo "## Sakura"
sudo apt install sakura -y

echo "## Rofi"
sudo apt install rofi -y

echo "## Gnome-Screenshot"
sudo apt install gnome-screenshot -y

echo "## Tema e iconos yaru"
sudo apt install yaru-theme-gtk -y
sudo apt install yaru-theme-icon -y





###################################
#			XFCE CONFIG
###################################
cp -r getXFCEConfig/xfce4/ $HOME/.config/xfce4/





###################################
#		AJUSTES AL SISTEMA
###################################
# Errores del S.O
#dpkg: cannot write to log file '/var/log/dpkg.log': No space left on device

#E: Error de escritura - ~LZMAFILE (28: No space left on device)


## Swappines al 25
 sudo sed -i '/vm.swappiness=100/cvm.swappiness=25' /etc/sysctl.conf 
