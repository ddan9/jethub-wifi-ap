#!/bin/bash

jethub_ap_interface="wlan0"

ifconfig $jethub_ap_interface 192.168.0.1 netmask 255.255.255.0 up

sysctl -w net.ipv4.ip_forward=1

kill $(ps aux | grep -v "grep" | grep "dhcpd" | awk '{print $2};'); sleep 1 && dhcpd -user dhcpd -group dhcpd -4 -cf /etc/dhcp/dhcpd.conf $jethub_ap_interface

systemctl start isc-dhcp-server
systemctl restart isc-dhcp-server

kill $(ps aux | grep -v "grep" | grep "hostapd" | awk '{print $2};'); sleep 1 && hostapd -dd -K -t -B /etc/hostapd/hostapd.conf
