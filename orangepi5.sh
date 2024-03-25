


## De forma centralizada registra los registros del sistema y servicios
sudo systemctl mask systemd-journal.service 




## Es responsable de la recopilación de datos de uso de recursos del sistema, como la CPU, la memoria, el disco y la red, para su posterior análisis y generación de informes.
##atop
##  |----> atopacctd
sudo systemctl disable atop
sudo systemctl disable atopacctd

## Registra los mensajes del sistema
sudo systemctl disable rsyslog.service 

## Es un servicio de programación de tareas
sudo systemctl disable cron

## es el componente del sistema que gestiona las conexiones SSH entrantes y salientes en el servidor.
sudo systemctl disable sshd

## proporciona la funcionalidad del Bluetooth
sudo systemctl disable bluetoothd

## Gestion de paquetes de software
sudo systemctl disable  packagekitd

## Entropia adicional / Generacion de numeros, Criptografia, seguridad
sudo systemctl disable haveged
sudo systemctl disable rngd

## Monotoriza y registra el trafico de red
sudo systemctl disable vnstatd.service

## Acceso y transferecias de archivos de sistemas remotos de forma segura
sudo systemctl disable ssh.service

## Gestiona la bateria y energia
sudo systemctl disable upower.service


## Soporte para la accesibilidad / asistencia
sudo systemctl mask at-spi-bus-launcher
sudo systemctl mask at-spi2-registryd.service

## Soporte para impresoras
sudo systemctl disable cups.service

################ APPS #####################
## Evolution
sudo apt remove evolution-data-server

## Thunderbird
sudo apt remove thunderbird



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


