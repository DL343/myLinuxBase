#!/bin/bash

########## ASEGURAR INSTALACION ########## 
sudo nala install icewm -y

########## CONFIGURACION INICIAL ########## 
cp -r /usr/share/icewm/ $HOME/.icewm/


########## ATAJOS ##########
cp iceWM/keys $HOME/.icewm/keys 


########## INICIO AUTOMATICO ##########
cp iceWM/startup $HOME/.icewm/startup

chmod +x $HOME/.icewm/startup


########## ESTABLECER TEMA ########## 
echo 'Theme="NanoBlue/default.theme"' > $HOME/.icewm/theme


########## ESTABLECER WALLPAPER ########## 
cp ./iceWM/wallpaper/* $HOME/.icewm/themes/NanoBlue/eos.jpg



