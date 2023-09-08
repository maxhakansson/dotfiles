#!/bin/bash
# Configure
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper begin

# Remove local DNSMasq server
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper delete service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 dns-server 192.168.0.100

# Remove Google DNS
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper delete service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 dns-server 8.8.8.8
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper delete service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 dns-server 4.4.4.4

# Set Open DNS
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 dns-server 208.67.220.220
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 dns-server 208.67.222.222

# Commit and save
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper commit
/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper end

exit 0
