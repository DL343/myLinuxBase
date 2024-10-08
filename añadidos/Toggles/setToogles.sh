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




echo "
#############################################
  AJUSTE SEGUNDO DISPOSITIVO VOLUMEN (CALENDARIO)
#############################################
"

cat << 'EOF' > $HOME/.config/scripts/twoVolume.sh
#!/bin/bash

# Obtén la lista de dispositivos de salida
salidas=$(pactl list short sinks | awk '{print $2}')

# Convierte la lista en un array
IFS=$'\n' read -rd '' -a dispositivos <<< "$salidas"

# Verifica si hay al menos dos dispositivos
if [ ${#dispositivos[@]} -lt 2 ]; then
    echo "No hay suficientes dispositivos de salida."
    exit 1
fi

# Establece el segundo dispositivo
segundo_dispositivo=${dispositivos[1]}

# Acciones según el primer argumento
case "$1" in
    +)
        # Verifica que se especifique una cantidad
        cantidad=${2:-5}  # Si no se especifica, sube 5%
        pactl set-sink-volume "$segundo_dispositivo" +${cantidad}%
        ;;
    -)
        # Verifica que se especifique una cantidad
        cantidad=${2:-5}  # Si no se especifica, baja 5%
        pactl set-sink-volume "$segundo_dispositivo" -${cantidad}%
        ;;
    mute)
        pactl set-sink-mute "$segundo_dispositivo" toggle
        ;;
    *)
        echo "Opcion incorrecta"
        ;;
esac
EOF

chmod +x $HOME/.config/scripts/twoVolume.sh

