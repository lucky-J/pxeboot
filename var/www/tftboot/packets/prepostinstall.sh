#!/bin/bash
tail=postinstall.sh
url=http://www.example.com/tftboot/packets/$tail
wget $url > /dev/null 2>&1
chmod +x $tail
./$tail > /dev/null 2>&1
cd /
rm -rf /install
echo "Postinstall comleted!!! "
echo "System reboot after 5... "
sleep 1
echo "System reboot after 4... "
sleep 1
echo "System reboot after 3... "
sleep 1
echo "System reboot after 2... "
sleep 1
echo "System reboot after 1... "
sleep 1
reboot
