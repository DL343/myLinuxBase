#!/usr/bin/env bash


source ./variables.sh

if [ "sysvinit" == "${init}" ]
then
	
	echo "sysVinit"

fi



if [ "systemd" == "${init}" ]
then

		echo "systemd"

fi

echo "#########################################"


cat << 'EOF' > /home/oso/tortuga.sh
#!/usr/bin/env bash
#=======================HEADER========================================|
#AUTOR
# Nicolas Longardi 'Locos por Linux' <nico@locosporlinux.com>
# Jefferson 'Slackjeff' Rocha <root@slackjeff.com.br>
# Creado totalmente en bash + YAD.
#===================================| VARIABLES
# Nombre del programa
PRG='Loc-OS Welcome'

# Version
VERSION='1.0'

# Archivo temporário para exclusion
temp="/etc/xdg/autostart/loc-oswelcome.desktop"

# Ubicacion de los iconos
icon='/usr/share/pixmaps/loc-oswelcome'

#===================================| INICIO
# Menu Principal
 yad --title="$PRG"            \
    --width="800"              \
    --height="450"             \
    --text-align=left          \
    --center                   \
    --image-on-top             \
    --undecorated              \
    --fontname="monospace 56"  \
    --image="${icon}/logo.png" \
    --borders=10               \
    --text="
<big><b>Loc-OS</b> Welcome</big>

Welcome, below you can check some options to install or configure the system.
Remember that the password of the <big><b>live</b></big> user is <big><b>live</b></big> and that of <big><b>root</b></big> is <big><b>root</b></big>."   \
   --form  --columns 4                                                                                     \
    --field="<b>Install</b>!${icon}/install.png!Install Loc-OS Linux on the HDD/SSD":BTN "/usr/bin/install-loc-os " \
    --field="<b>Website</b>!${icon}/site.png!Official site of Loc-OS":BTN "xdg-open https://loc-os.sourceforge.io/"           \
    --field="<b>LPKG</b>!${icon}/lpkg.png!Loc-OS Package Manager":BTN "/opt/Loc-OS-LPKG/.sudo/sudogui /opt/Loc-OS-LPKG/LpkgGui"   \ "
yad --width='500'
     --height='100'
     --center
     --undecorated
     --image="${icon}/sobreyad.png"
     --borders=5
     --text-align=left
     --text='

<big><b>$PRG</b></big>

Loc-OS Linux is a free GNU/Linux distribution, oriented to low resource consumption. Free from systemd and based on Debian stable.

<b>Version:</b> $VERSION
<b>License:</b> GPLv3
<b>Contact:</b> nico@locosporlinux.com'
     --button="Exit":1
"                                                                                                           \ "
"                                                                                                       \
    --field="<b>About</b>!${icon}/sobre.png!About this proyect":BTN  "xdg-open ${sites[4]}"            \
    --button="Exit":1

# El inicio automatico debe ser apenas en el primer boot.
# Luego debe ser excluido.
if [[ -e "$temp" ]]; then
    rm "$temp"
fi

EOF
