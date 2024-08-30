
#!/bin/bash

if pgrep -x "nm-applet" > /dev/null
then
	pkill nm-applet
else
	nm-applet &
fi


