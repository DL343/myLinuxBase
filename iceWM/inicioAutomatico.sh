#!/bin/bash

touch $HOME/.icewm/startup

echo '#!/bin/bash

redshift -O 4250K -r -P &&
brightnessctl s 0 &&

' >> $HOME/.icewm/startup

chmod +x $HOME/.icewm/startup
