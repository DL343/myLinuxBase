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


echo "## Listo"
