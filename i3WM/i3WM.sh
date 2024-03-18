#!/bin/bash


## Deshabilitando secciones sin usar
sed -i '/bindsym $mod+d exec --no-startup-id dmenu_run/c\##### [__CUSTOM__] bindsym $mod+d exec --no-startup-id dmenu_run' $HOME/.config/i3/config


## Rofi
sed -i '/# bindcode $mod+40 exec "rofi -modi drun,run -show drun"/c\bindsym $mod+d exec \"rofi -modi drun,run -show-icons -theme \/usr\/share\/rofi\/themes\/gruvbox-dark-hard.rasi -font '\''URW Gothic 14'\'' -show drun\"' $HOME/.config/i3/config



echo '


############### CUSTOM STARTUP ###################

exec --no-startup-id /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 
exec redshift -O 4250K -r -P 
exec brightnessctl s 0 
exec xscreensaver -nosplash
## exec parcellite 
 


################# CUSTOM #################


bindsym mod1+KP_Subtract              exec amixer sset Master 5%-
bindsym mod1+KP_Add                   exec amixer sset Master 5%+
bindsym mod1+KP_Multiply              exec amixer sset Master toggle

bindsym XF86MonBrightnessDown         exec brightnessctl s 10%-
bindsym XF86MonBrightnessUp           exec brightnessctl s 10%+

#bindsym Ctrl+Alt+t                   sakura
#bindsym Super+Enter                  sakura
bindsym $mod+mod1+f                   exec thunar
bindsym $mod+mod1+e                   exec geany
#bindsym Super+m                      vlc
bindsym Ctrl+Shift+Escape             exec i3-sensible-terminal -x htop

#bindsym Print                        gnome-screenshot -i
bindsym Print                         exec gnome-screenshot
bindsym Ctrl+Print                    exec gnome-screenshot -w
bindsym mod1+Print                    exec gnome-screenshot -a

bindsym $mod+F2                       exec $HOME/.config/scripts/toggle_nm-applet.sh

# Color de los bordes enfocados
##                               Bordes     Fondo      Texto
client.focused                   #000000    #ffdd00    #000000
## client.unfocused               
## client.focused_inactive        
## client.urgent                  


' >> $HOME/.config/i3/config
