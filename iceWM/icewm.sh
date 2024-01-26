#!/bin/bash

########## ASEGURAR INSTALACION ########## 
sudo nala install icewm

########## CONFIGURACION INICIAL ########## 
cp -r /usr/share/icewm/ $HOME/.icewm/


########## ATAJOS ##########
echo "

################# CUSTOM #################
key "Alt+Ctrl+t"                  sukura
key "XF86MonBrightnessDown"       brightnessctl s 10%-
key "XF86MonBrightnessUp"         brightnessctl s 10%+     
key "Print"                       gnome-screenshot -i
key "Super+Space"                 rofi -show-icons -show drun
# key "Ctrl+F2"                   
# key "F2"
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

