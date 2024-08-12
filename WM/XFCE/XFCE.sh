#!/bin/bash



echo "
########## ASEGURAR INSTALACION ########## 
"
sudo apt install xfdesktop4 xfwm4 xfce4-panel xfce4-settings xfce4-session --no-install-recommends -y

echo "## Listo"




echo "
########## CONFIGURACION ########## 
"

## Copiado de la configuracion
cp -rp ./getXFCEConfig/xfce4/ $HOME/.config/

