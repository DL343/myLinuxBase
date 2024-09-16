#!/bin/bash

## ICEWM
##cp -r /usr/share/icewm/ $HOME/
##mv $HOME/icewm $HOME/.icewm
mkdir -p ./getICEWMConfig/.icewm/themes/Arc-Dark/ 

dirICEWM=./getICEWMConfig/.icewm/

cp $HOME/.icewm/keys	      $dirICEWM
cp $HOME/.icewm/startup	      $dirICEWM
cp $HOME/.icewm/theme         $dirICEWM
cp $HOME/.icewm/preferences   $dirICEWM
cp $HOME/.icewm/toolbar       $dirICEWM

cp -r $HOME/.icewm/themes/Arc-Dark/  $dirICEWM/themes/

