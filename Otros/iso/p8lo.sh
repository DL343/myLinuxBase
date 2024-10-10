#!/usr/bin/env bash

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



