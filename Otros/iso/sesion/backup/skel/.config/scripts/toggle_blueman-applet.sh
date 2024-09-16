
#!/bin/bash

if pgrep -x "blueman-applet" > /dev/null
then
        pkill blueman-applet
else
        blueman-applet &
fi


