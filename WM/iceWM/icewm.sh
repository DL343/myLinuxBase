#!/bin/bash

Listo='echo "Hecho"'

echo "
########## ASEGURAR INSTALACION ########## 
"
sudo apt install icewm

$Listo

echo "
########## CONFIGURACION INICIAL ########## 
"
rm -r ~/.icewm/

cp -r /usr/share/icewm/ ~/.icewm


$Listo

echo "
########## ATAJOS ##########
"

cp ./keys ~/.icewm/keys 


$Listo

echo "
########## INICIO AUTOMATICO ##########
"

cp ./startup ~/.icewm/startup

chmod +x ~/.icewm/startup


$Listo

echo "
########## ESTABLECER TEMA ########## 
"

echo 'Theme="NanoBlue/default.theme"' > $HOME/.icewm/theme

rm ~/.icewm/themes/NanoBlue/eos.jpg

$Listo



