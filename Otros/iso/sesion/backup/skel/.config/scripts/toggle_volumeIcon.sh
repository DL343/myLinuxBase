
#!/bin/bash

if pgrep -x "volumeicon" > /dev/null
then
        pkill volumeicon
else
        volumeicon &
fi


