
#!/bin/bash

if pgrep -x "orage" > /dev/null
then
        pkill orage
else
        orage &
fi


