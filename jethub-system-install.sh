#!/bin/bash

#
# This script created for JetHub H1
# Script makes it able to use AP (Access Point) Wi-Fi mode
# Target OS: Armbian, but i think it will work on Ubuntu too
# Target Device: JetHub H1, Fn-Link 6222B-SRC (RTL8822CS), meson64 (aarch64, ARM64)
# Please check all this script before use it, change credentials below (if you want of course)
# After executing this script it should be able to use second script: jethub-start-ap.sh
# You may need to remove or change some lines about disabling services and so on
#

jethub_ap_interface="wlan0"
jethub_ap_country_code="RU"
jethub_ap_ssid="JetHub_$(echo $(date) $(lscpu) $(lspci) | md5sum | awk '{print $1};' | cut -c 1-6)"
jethub_ap_channel="$(echo $((1 + $RANDOM % 12)))"
jethub_ap_passphrase="$(pwgen -c -n -s -B -1 14)"

##################################
# DISPLAY CREDENTIALS AND CHOOSE #
##################################

echo ""
echo "Interface: $jethub_ap_interface"
echo "Country: $jethub_ap_country_code"
echo "SSID: $jethub_ap_ssid"
echo "Channel: $jethub_ap_channel"
echo "Password: $jethub_ap_passphrase"
echo ""

echo -n "Selected credentials are right? Continue? (y/n): "

read choose

if [[ $choose == "y" ]]

	then

		sleep 5

		echo "[!] Continuing..."

	else

		echo "[!] Exiting..."

		exit 0

fi

#######################################
# INSTALLING ALL DEPENDS AND UPDATING #
#######################################

apt update && apt upgrade -y && apt dist-upgrade -y && apt install -y -f

apt install -y net-tools wireless-tools nmap mc nano iproute2 armbian-firmware-full linux-headers-current-meson64 module-assistant git hostapd isc-dhcp-server build-essential pwgen lshw

groupadd -r dhcpd
useradd -r -g dhcpd dhcpd

systemctl stop isc-dhcp-server
systemctl disable isc-dhcp-server

###########################
# CONFIGURING DHCP SERVER #
###########################

cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.bak.$(ls -l /etc/default/ | grep -c "isc-dhcp-server")

echo "
DHCPD_CONF='/etc/dhcp/dhcpd.conf'
DHCPDv4_CONF='/etc/dhcp/dhcpd.conf'
DHCPD_PID='/var/run/dhcpd.pid'
DHCPDv4_PID='/var/run/dhcpd.pid'
OPTIONS='-d'
INTERFACES='$jethub_ap_interface'
INTERFACESv4='$jethub_ap_interface'
" > /etc/default/isc-dhcp-server

cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak.$(ls -l /etc/dhcp/ | grep -c "dhcpd.conf")

echo "
ddns-update-style none;
default-lease-time 600;
max-lease-time 7200;
authoritative;
log-facility local7;

subnet 192.168.0.0 netmask 255.255.255.0 {
	range 192.168.0.10 192.168.0.20;
	option routers 192.168.0.1;
	option broadcast-address 192.168.0.255;
	option subnet-mask 255.255.255.0;
	option netbios-name-servers 192.168.0.1;
	option domain-name-servers 192.168.0.1, 8.8.8.8, 8.8.4.4;
	default-lease-time 600;
	max-lease-time 7200;
}
" > /etc/dhcp/dhcpd.conf

#######################
# CONFIGURING HOSTAPD #
#######################

cp /etc/default/hostapd /etc/default/hostapd.bak.$(ls -l /etc/default/ | grep -c "hostapd")

echo "
DAEMON_CONF='/etc/hostapd/hostapd.conf'
DAEMON_OPTS='-dd -K -t'
" > /etc/default/hostapd

cp /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.bak.$(ls -l /etc/hostapd/ | grep -c "hostapd.conf")

echo "
interface=$jethub_ap_interface
driver=nl80211
ctrl_interface=/var/run/hostapd.pid
ctrl_interface_group=0
country_code=$jethub_ap_country_code
ieee80211d=1
ieee80211h=1
ieee80211n=1
hw_mode=g
max_num_sta=16
macaddr_acl=0
preamble=1
ignore_broadcast_ssid=0
wmm_enabled=1
ap_max_inactivity=99999
skip_inactivity_poll=1
disassoc_low_ack=0
wds_sta=1
wps_state=0
wpa=2
auth_algs=1
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
rsn_pairwise=CCMP
ssid=$jethub_ap_ssid
channel=$jethub_ap_channel
wpa_passphrase=$jethub_ap_passphrase
" > /etc/hostapd/hostapd.conf

################################################
# GET COMPILE AND INSTALL ALTERNATE RTL DRIVER #
################################################

echo ""
echo -n "Do you wish to get, compile and install another Realtek (88x2cs) driver? (y/n): "

read choose

if [[ $choose == "y" ]]

	then

		sleep 5

		echo "[!] Preparing to compiling..."

		cd

		git clone https://github.com/jethome-ru/rtl88x2cs rtl-8822cs-jethub

		cd ./rtl-8822cs-jethub

		m-a prepare

		ln -s /usr/src/linux-headers-$(uname -r) /lib/modules/$(uname -r)/build

		make -j$(($(nproc)-1)) ARCH=arm64 KSRC=/usr/lib/modules/$(uname -r)/build

		make install

		depmod -a

		modprobe -r rtw_8822cs
		modprobe -r rtw88_8822cs
		modprobe -r rtw88_8822c

		modprobe 88x2cs

		rm -rf rtl-8822cs-jethub

	else

		echo "[!] Continuing without it..."

		sleep 0

fi

###########################
# BLACKLISTING RTW DRIVER #
###########################

echo "
blacklist rtw_8822cs
blacklist rtw88_8822cs
blacklist rtw88_8822c
#install rtw_8822cs /bin/false
" > /etc/modprobe.d/rtw_8822cs.conf

#################################
# UPDATING INITRAMFS AND REBOOT #
#################################

update-initramfs -u

echo ""
echo -n "All is right? Reboot? (y/n): "

read choose

if [[ $choose == "y" ]]

	then

		sleep 5

		echo "[!] Continuing..."

		reboot

	else

		echo "[!] Exiting..."

		exit 0

fi
