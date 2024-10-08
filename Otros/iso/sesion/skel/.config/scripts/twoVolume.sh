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
