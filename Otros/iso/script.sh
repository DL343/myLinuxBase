

echo '
#!/bin/bash

userdel -r live

rm -- "$0"
' > /usr/local/bin/remove-live-user.sh

chmod +x /usr/local/bin/remove-live-user.sh


echo "script: /usr/local/bin/remove-live-user.sh" | tee -a /etc/calamares/settings.conf &> /dev//null




