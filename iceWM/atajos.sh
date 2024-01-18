#!/bin/bash

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
