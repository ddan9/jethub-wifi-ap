#!/bin/bash

jethub_ap_interface="wlan0"
set_full_remove=

while [ -n "$1" ]

do

	case "$1" in

		--full-remove-interface) set_full_remove="true" ;;

		*) set_full_remove="false" ;;

	esac

	shift

done

if [[ $set_full_remove != "true" ]]

	then

		echo "[!] Using fast remove..."

		kill $(ps aux | grep -v "grep" | grep "hostapd" | awk '{print $2};')

		systemctl stop isc-dhcp-server

		kill $(ps aux | grep -v "grep" | grep "dhcpd" | awk '{print $2};')

		iwconfig $jethub_ap_interface mode managed

	else

		echo "[!] Using full remove..."

		kill $(ps aux | grep -v "grep" | grep "hostapd" | awk '{print $2};')

		systemctl stop isc-dhcp-server

		kill $(ps aux | grep -v "grep" | grep "dhcpd" | awk '{print $2};')

		iwconfig $jethub_ap_interface mode managed

		ifconfig $jethub_ap_interface down

fi
