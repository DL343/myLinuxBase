#!/usr/bin/env bash

echo "
########################################################################
############################## CALAMARES ##############################
########################################################################
"
## Icono 
#

## Entrada en el escritorio
#


echo "
########################################################################
############################## REPO MANAGER ##############################
########################################################################
"

## Instalacion
apt -y install repo-manager-loc-os_0.3_all.deb 


echo "
########################################################################
############################## WELCOME ##############################
########################################################################
"

## Instalacion
apt -y install 

## Cambio de iconos
cp ./LO/Welcome/Waterfox.png  /opt/browsers/icons/firefox.png

## Ajuste script eliminacion firefox => waterfox
cp ./LO/Welcome/chromium.sh /opt/browsers/scripts/chromium.sh

sh -c 'xrandr --output Virtual-1 --mode 1360x768'

## Autoinicio de Welcome para iceWM
echo "/bin/loc-oswelcome.sh" >>  $HOME/.icewm/startup 



