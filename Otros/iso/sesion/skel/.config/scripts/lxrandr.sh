#!/bin/bash

# Leer extraer la línea que comienza con 'Exec'
line=$(grep '^Exec=' $HOME/.config/autostart/lxrandr-autostart.desktop)

# Extraer el comando entre comillas simples
command=${line#*\'}
command=${command%\'*}

# Ejecutar el comando extraído
$command


