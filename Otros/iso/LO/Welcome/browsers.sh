#!/usr/bin/env bash
#==================HEADER===================|
# AUTOR
# Nicolas Longardi <nico@locosporlinux.com>
# Creado totalmente en bash + YAD.
#===================================| VARIABLES
# Ubicacion de los iconos
icon='/opt/browsers/icons/'
#===================================| INICIO
pkill yad
# Menu Principal
 yad --title="Browsers"            \
    --width="800"              \
    --height="350"             \
    --text-align=left          \
    --center                   \
    --image-on-top             \
    --undecorated              \
    --fontname="monospace 56"  \
    --image="${icon}/browsers.png" \
    --borders=10               \
    --text="
<big><b> Browsers</b></big>

 Please, choose a web browser between <b>Chromium</b> and <b>Waterfox</b> to install with Loc-OS. \n
 Alternatively, select <b>NO BROWSERS</b> for do not wish to install any browser (can you install another browser after the installation).

"   \
   --form  --columns 3                                                                                     \
    --field="<b> Chromium</b>!${icon}/chromium.png!Install Chromium browser on Loc-OS Linux":BTN "${icon}/../scripts/chromium.sh " \
    --field="<b> Waterfox</b>!${icon}/waterfox.png!Install Waterfox on Loc-OS Linux":BTN "${icon}/../scripts/firefox.sh"           \
    --field="<b> No browsers</b>!${icon}/X.png!Install Loc-OS without any browser":BTN "${icon}/../scripts/nobrowsers.sh"   \ "
"

