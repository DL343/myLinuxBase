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

' > $HOME/.config/scripts/toggle_network-applet.sh

chmod +x $HOME/.config/scripts/toggle_network-applet.sh





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


echo "
#############################################
    TOGGLE VOLUMEICON(ICONO VOLUMEN)
#############################################
"

## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
echo '
#!/bin/bash

if pgrep -x "volumeicon" > /dev/null
then
        pkill volumeicon
else
        volumeicon &
fi

' > $HOME/.config/scripts/toggle_volumeIcon.sh

chmod +x $HOME/.config/scripts/toggle_volumeIcon.sh




echo "
#############################################
    TOGGLE ZENITY --CALENDAR (CALENDARIO)
#############################################
"
## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
echo '
#!/bin/bash

if pgrep -x "zenity" > /dev/null
then
        pkill zenity
else
        zenity --calendar &
fi

' > $HOME/.config/scripts/toggle_zenityCalendar.sh

chmod +x $HOME/.config/scripts/toggle_zenityCalendar.sh







