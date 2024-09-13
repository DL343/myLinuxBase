#!/bin/bash

echo "backend: apt

operations:
  - remove:
      - 'live-boot'
      - 'live-boot-doc'
      - 'live-config'
      - 'live-config-doc'
      - 'live-tools'
      - 'calamares'
      - 'calamares-settings-loc-os'
      - 'welcome-loc-os'
      - 'waterfox'" > /etc/calamares/modules/packages.conf
pkill yad
/usr/bin/install-loc-os
exit 0
