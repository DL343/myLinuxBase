#!/usr/bin/env bash


## 5. Retoques:

nombreDistro=Prueba001

####################################################
####################### SKEL #######################
####################################################

## Creacion de la carpeta por si no existe
mkdir -p /etc/skel

## Copia de home's
cp -r ./sesion/skel/ /etc/
cp -r ./sesion/live/ /home/

## Ajuste de permisos
chown live /home/live -R



####################################################
##################  CALAMARES ######################
####################################################

## Icono de la aplicacion calamares
#cp ./calamares-loc-os.png /usr/share/icons/hicolor/48x48/apps/calamares-loc-os.png

## Aplicacion
#cp ./calamares.desktop /home/live/Desktop/Instalar.desktop


####################################################
################### A ELIMINAR #####################
####################################################

#sudo apt remove aspell-es chafa cups-pk-helper debian-reference-es debian-reference-common fonts-liberation git ispanish task-spanish manpages-es system-config-printer system-config-printer-common python3-gi-cairo python3-cairo system-config-printer-udev python3-cupshelpers python3-cups python3-smbc rtkit 
##blueman

####################################################
################### HOSTNAME #####################
####################################################
echo "$nombreDistro" > /etc/hostname


####################################################
################# DISPLAY MANAGER ##################
####################################################
sed -i 's/#autologin-user=/autologin-user=live/g' /etc/lightdm/lightdm.conf
sed -i 's/#autologin-user-timeout=0/autologin-user-timeout=0/g' /etc/lightdm/lightdm.conf
sed -i 's/#autologin-session=/autologin-session=icewm/g' /etc/lightdm/lightdm.conf 


####################################################
########## Fix Boot Errors ##########
####################################################

apt -y install insserv
insserv -r smartd
insserv -r apparmor
insserv -r smartmontools


reboot
