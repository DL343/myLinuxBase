#!/bin/bash

echo "
########## ASEGURAR INSTALACION ########## 
"
sudo apt install i3 -y

echo "## Listo"





echo "
########## CONFIGURACION ########## 
"

echo "## Agregar configuraciones" 
cp -rp ./geti3WMConfig/i3 $HOME/.config/

echo "## Listo"

