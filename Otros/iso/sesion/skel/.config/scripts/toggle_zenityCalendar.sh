
#!/bin/bash

if pgrep -x "zenity" > /dev/null
then
        pkill zenity
else
        zenity --calendar &
fi


