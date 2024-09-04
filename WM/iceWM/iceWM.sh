#!/bin/bash



echo "
########## ASEGURAR INSTALACION ########## 
"
sudo apt install icewm -y

echo "## Listo"





echo "
########## CONFIGURACION ########## 
"

echo "## Agregar configuraciones" 
cp -rp ./getICEWMConfig/.icewm/ $HOME/

## Mostar fecha y hora IceWM
sed -i '/TimeFormat=/c  TimeFormat="%x | %H:%M"' $HOME/.icewm/preferences


echo "## Listo"
