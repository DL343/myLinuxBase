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
apt -y install repo-manager-loc-os


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

## Autoinicio de Welcome para iceWM
if grep -q "/bin/loc-oswelcome.sh" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "/bin/loc-oswelcome.sh" >>  /home/live/.icewm/startup 
fi


