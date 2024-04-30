#!/bin/bash

#
# Script for stopping already started Wi-Fi AP
# Use it only after jethub-system-install.sh script
#

###########################
# PREINITIALIZE VARIABLES #
###########################

jethub_ap_interface="wlan0"
set_full_remove=

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

###################################
# CHECK FOR ADDITIONAL PARAMETERS #
###################################

while [ -n "$1" ]

do

	case "$1" in

		--full-remove-interface) set_full_remove="true" ;;

		*) set_full_remove="false" ;;

	esac

	shift

done

#################
# MAIN WORKLOAD #
#################

if [[ $set_full_remove != "true" ]]

	then

		echo ""
		echo "[!] Using fast remove..."
		echo ""

		kill $(ps aux | grep -v "grep" | grep "hostapd" | awk '{print $2};')

		systemctl stop isc-dhcp-server

		kill $(ps aux | grep -v "grep" | grep "dhcpd" | awk '{print $2};')

		iwconfig $jethub_ap_interface mode managed

	else

		echo ""
		echo "[!] Using full remove..."
		echo ""

		kill $(ps aux | grep -v "grep" | grep "hostapd" | awk '{print $2};')

		systemctl stop isc-dhcp-server

		kill $(ps aux | grep -v "grep" | grep "dhcpd" | awk '{print $2};')

		iwconfig $jethub_ap_interface mode managed

		ifconfig $jethub_ap_interface down

fi

###########
# THE END #
###########
