#!/bin/bash

# 1. INSTALACION DE LA BASE (ALSA)  
sudo nala install alsa-oss alsa-tools alsa-utils


## 2. INSTALACION DE UN SERVIDOR DE AUDIO(PULSEADUIO, PIPEWIRE)
### PIPEWIRE
## // Paso 1.  
sudo nala install pipewire-audio wireplumber pipewire-pulse pipewire-alsa libspa-0.2-bluetooth pavucontrol

## // Paso 2.  
systemctl --user --now enable pipewire pipewire-pulse  
systemctl --user --now enable wireplumber.service
