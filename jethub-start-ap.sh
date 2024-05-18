#!/bin/bash

#
# Script for starting or restarting already configured Wi-Fi AP
# Use it only after jethub-system-install.sh script
#

###########################
# PREINITIALIZE VARIABLES #
###########################

jethub_ap_interface="wlan0"

#########################
# ROOT PRIVILEGES CHECK #
#########################

if [[ $(id -u) != 0 ]]

	then

		echo ""
		echo "[!] Please run this script as root or using sudo!"
		echo ""

		exit

	else

		sleep 0

fi

#################
# MAIN WORKLOAD #
#################

ifconfig $jethub_ap_interface 192.168.100.1 netmask 255.255.255.0 up

sysctl -w net.ipv4.ip_forward=1

rm -rf /var/lib/dhcp/*.leases*

touch /var/lib/dhcp/dhcpd.leases

chown -R dhcpd:dhcpd /var/lib/dhcp/dhcpd.leases

kill $(ps aux | grep -v "grep" | grep "dhcpd" | awk '{print $2};'); sleep 1 && dhcpd -user dhcpd -group dhcpd -4 -cf /etc/dhcp/dhcpd.conf $jethub_ap_interface

sleep 2

systemctl start isc-dhcp-server

kill $(ps aux | grep -v "grep" | grep "hostapd" | awk '{print $2};'); sleep 1 && hostapd -dd -K -t -B /etc/hostapd/hostapd.conf

####################
# SHOW CREDENTIALS #
####################

echo ""
echo " --- YOUR WI-FI CREDENTIALS --- "
echo -e "SSID: $(cat /etc/hostapd/hostapd.conf | grep -v 'ignore' | grep 'ssid' | awk -F '=' '{print $2};')"
echo -e "PASS: $(cat /etc/hostapd/hostapd.conf | grep 'wpa_passphrase' | awk -F '=' '{print $2};')"
echo ""

###########
# THE END #
###########
