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
apt -y install ./LO/repo-manager/repo-manager-loc-os_0.3_all.deb 


echo "
########################################################################
############################## WELCOME ##############################
########################################################################
"
mkdir -p /usr/share/pixmaps/loc-oswelcome/

## Copiado
cp ./LO/welcome/assets/* /usr/share/pixmaps/loc-oswelcome/
cp ./LO/welcome/loc-oswelcome.sh /bin/loc-oswelcome.sh

## Autoinicio al arranque del usuario live
mkdir -p /home/live/.config/autostart/
cp ./LO/welcome/Welcome.desktop /home/live/.config/autostart/Welcome.desktop

## Ajuste de permisos
chown -R live /home/live/ 


echo "
########################################################################
########################### BROWSER SELECTOR ###########################
########################################################################
"




