#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo 
	echo '[!] Run as root [!]'
	exit
fi

mullvad status
echo
echo '[wlan0 info]'
macchanger -s wlan0
echo
echo '[eth0 info]'
macchanger -s eth0

echo
read -p 'Anonimise? [Y/N]: ' YN

case $YN in
	Y) mullvad connect && ip link set wlan0 down && ip link set eth0 down && macchanger -r wlan0 && macchanger -r eth0 && ip link set wlan0 up && ip link set eth0 up && clear && macchanger -s wlan0 && echo && macchanger -s eth0 && echo && echo 'Session is secure.' && exit;;
	N) exit;;
	*) echo 'invalid input, input is case sensitive' && sleep 3 && exit 1;;
esac
exit
