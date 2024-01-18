#!/bin/bash

# 1. INSTALACION DE LA BASE (ALSA)  
sudo nala install alsa-oss alsa-tools alsa-utils -y


## 2. SERVIDOR DE AUDIO(PULSEADUIO, PIPEWIRE)
### PIPEWIRE
## // Paso 1.  Instalacion
sudo nala install pipewire-audio wireplumber pipewire-pulse pipewire-alsa libspa-0.2-bluetooth pavucontrol -y

## // Paso 2.  Configuracion
systemctl --user --now enable pipewire pipewire-pulse  
systemctl --user --now enable wireplumber.service
