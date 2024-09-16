#!/bin/bash



echo "
########## ASEGURAR INSTALACION ########## 
"
sudo apt install icewm -y

echo "


"







echo "## Agregar configuraciones" 
cp -rp ./getICEWMConfig/.icewm/ $HOME/



echo "## Listo"
