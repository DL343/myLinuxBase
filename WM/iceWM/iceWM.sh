#!/bin/bash



echo "
########## ASEGURAR INSTALACION ########## 
"
sudo apt install icewm -y

echo "


"







echo "## Agregar configuraciones" 
cp -r ./getICEWMConfig/.icewm/  $HOME/

echo "## Listo"
