#!/bin/bash

echo "
#############################################
             TOGGLE NM-APPLET
#############################################
"

mkdir -p $HOME/.config/scripts/

echo '
#!/bin/bash

if pgrep -x "nm-applet" > /dev/null
then
	pkill nm-applet
else
	nm-applet &
fi

' > $HOME/.config/scripts/toggle_nm-applet.sh

chmod +x $HOME/.config/scripts/toggle_nm-applet.sh





echo "
#############################################
     TOGGLE BLUEMAN-APPLET (BLUETOOTH)
#############################################
"

## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
echo '
#!/bin/bash

if pgrep -x "blueman-applet" > /dev/null
then
        pkill blueman-applet
else
        blueman-applet &
fi

' > $HOME/.config/scripts/toggle_blueman-applet.sh

chmod +x $HOME/.config/scripts/toggle_blueman-applet.sh




echo "
#############################################
         TOGGLE ORAGE (CALENDARIO)
#############################################
"
## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
echo '
#!/bin/bash

if pgrep -x "orage" > /dev/null
then
        pkill orage
else
        orage &
fi

' > $HOME/.config/scripts/toggle_orage.sh

chmod +x $HOME/.config/scripts/toggle_orage.sh



echo "
#############################################
    TOGGLE DISTRIBUCION TECLADO US/LATAM
#############################################
"
## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
echo '
#!/bin/bash

## Listar mas opciones
#localectl list-x11-keymap-layouts

setxkbmap -layout latam,us -option "grp:alt_shift_toggle"

' > $HOME/.config/scripts/toggle_us_latam.sh  

chmod +x $HOME/.config/scripts/toggle_us_latam.sh  

