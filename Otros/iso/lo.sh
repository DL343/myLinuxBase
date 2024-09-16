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
apt -y install welcome-loc-os

## Cambio de iconos
cp ./LO/Welcome/waterfox.png  /opt/browsers/icons/

## Ajuste script eliminacion (firefox => waterfox)
cp ./LO/Welcome/chromium.sh /opt/browsers/scripts/chromium.sh

## Ajuste textos interfaz yad
cp ./LO/Welcome/browsers.sh /bin/browsers.sh

## Autoinicio de Welcome para iceWM
if grep -q "/bin/loc-oswelcome.sh" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "/bin/loc-oswelcome.sh" >>  /home/live/.icewm/startup 
fi


