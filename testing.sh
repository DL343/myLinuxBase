#!/bin/bash

	if [ command -v pulseaudio &>/dev/null ]; then                      #### PENDIENTE DE COMPROBAR SI FUNCIONA
		## PulseAudio detectado. Desinstalando...
		systemctl --user --now disable pulseaudio.service pulseaudio.socket
	else 
		echo "No existe pulseaudio, continuando al siguiente paso..."
	fi



