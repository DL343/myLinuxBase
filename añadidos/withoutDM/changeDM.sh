#!/bin/bash


echo "
###################################
      CHANGE DISPLAY MANAGER
###################################
"



read -p "¿Que WM desea aplicar?: " WM

## Configuracion de startx
echo "$WM" > ~/.xinitrc

 

echo "
--------------
     LISTO
--------------

"
