#!/bin/bash

########## ASEGURAR INSTALACION ########## 
sudo nala install icewm

########## CONFIGURACION INICIAL ########## 
cp -r /usr/share/icewm/ $HOME/.icewm/


########## ATAJOS ##########
echo "

################# CUSTOM #################
key XF86AudioLowerVolume        amixer sset Master 5%-
key XF86AudioRaiseVolume        amixer sset Master 5%+
key XF86AudioMute               amixer sset Master toggle

key Alt+KP_Subtract             amixer sset Master 5%-
key Alt+KP_Add                  amixer sset Master 5%+
key Alt+KP_Multiply             amixer sset Master toggle

key XF86MonBrightnessDown       brightnessctl s 10%-
key XF86MonBrightnessUp         brightnessctl s 10%+

key Super+Enter                 sakura
key Super+f                     thunar
key Super+e                     geany
key Super+m                     vlc
key Ctrl+Shift+Escape           sakura -x htop

#key Print                      gnome-screenshot -i
key Print                       gnome-screenshot
key Ctrl+Print                  gnome-screenshot -w
key Alt+Print                   gnome-screenshot -a
key Super+Space                 rofi -show-icons -show drun


" >> $HOME/.icewm/keys 


########## INICIO AUTOMATICO ##########
touch $HOME/.icewm/startup

echo '#!/bin/bash

redshift -O 4250K -r -P &
brightnessctl s 0 &
parcellite &

' >> $HOME/.icewm/startup

chmod +x $HOME/.icewm/startup


########## ESTABLECER TEMA ########## 
echo 'Theme="NanoBlue/default.theme"' > $HOME/.icewm/theme


########## ESTABLECER WALLPAPER ########## 
cp ./iceWM/wallpaper/* $HOME/.icewm/themes/NanoBlue/eos.jpg

