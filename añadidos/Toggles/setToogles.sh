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
         CONTROL SEGUNDO VOLUMEN +
#############################################
"
## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
cat << 'EOF' > $HOME/.config/scripts/secondVolume+.sh
#!/bin/bash

# Obtén la lista de dispositivos de salida
sinks=$(pactl list short sinks | awk '{print $1}')

# Conviértelo en una lista
sink_list=($sinks)

# Verifica si hay al menos dos dispositivos
if [ ${#sink_list[@]} -lt 2 ]; then
    echo "Menos de dos dispositivos de salida conectados."
    exit 1
fi

# Selecciona el segundo dispositivo
second_sink=${sink_list[1]}

# Ajusta el volumen del segundo dispositivo
pactl set-sink-volume "$second_sink" +5%
EOF


chmod +x $HOME/.config/scripts/secondVolume+.sh 


echo "
#############################################
         CONTROL SEGUNDO VOLUMEN -
#############################################
"
## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
cat << 'EOF' > $HOME/.config/scripts/secondVolume-.sh
#!/bin/bash

# Obtén la lista de dispositivos de salida
sinks=$(pactl list short sinks | awk '{print $1}')

# Conviértelo en una lista
sink_list=($sinks)

# Verifica si hay al menos dos dispositivos
if [ ${#sink_list[@]} -lt 2 ]; then
    echo "Menos de dos dispositivos de salida conectados."
    exit 1
fi

# Selecciona el segundo dispositivo
second_sink=${sink_list[1]}

# Ajusta el volumen del segundo dispositivo
pactl set-sink-volume "$second_sink" -5%
EOF

chmod +x $HOME/.config/scripts/secondVolume-.sh 

echo "
#############################################
         CONTROL SEGUNDO VOLUMEN /
#############################################
"
## Creacion de la ubicacion
mkdir -p $HOME/.config/scripts/


## Creacion del script
cat << 'EOF' > $HOME/.config/scripts/secondVolumeMute.sh
#!/bin/bash

# Obtén la lista de dispositivos de salida
sinks=$(pactl list short sinks | awk '{print $1}')

# Conviértelo en una lista
sink_list=($sinks)

# Verifica si hay al menos dos dispositivos
if [ ${#sink_list[@]} -lt 2 ]; then
    echo "Menos de dos dispositivos de salida conectados."
    exit 1
fi

# Selecciona el segundo dispositivo
second_sink=${sink_list[1]}

# Ajusta el volumen del segundo dispositivo
pactl set-sink-mute "$second_sink" toggle
EOF

chmod +x $HOME/.config/scripts/secondVolumeMute.sh 


