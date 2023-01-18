#!/bin/sh

set -e

OPTIONS=$@
MIBS_DIR=/usr/share/snmp/mibs

##
## Settings - Replace variables
##

# Modify snmp.conf
sed -i".orig" "s/mibs :/mibs all/" /etc/snmp/snmp.conf

# Modify snmpd.conf
cp -p /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig
sed -i -e "s/agentAddress  udp:127.0.0.1:161/agentAddress  udp:161/" \
    -i -e "s/view   systemonly  included   .1.3.6.1.2.1.1/#view   systemonly  included   .1.3.6.1.2.1.1/" \
    -i -e "s/view   systemonly  included   .1.3.6.1.2.1.25.1/#view   systemonly  included   .1.3.6.1.2.1.25.1/" \
    -i -e "s/rocommunity public  default    -V systemonly/rocommunity public default/" \
    -i -e "s/rocommunity6 public  default   -V systemonly/#rocommunity6 public  default   -V systemonly/" /etc/snmp/snmpd.conf

# Replace sysContact if environment variable `ADMIN` defined
if [ -n "${ADMIN}" ]; then
  sed -i -e "s/sysContact     Me <me@example.org>/sysContact     ${ADMIN}/" /etc/snmp/snmpd.conf
fi


##
## Download mibs
##
download-mibs

# Additional MIBs
# wget http://www.iana.org/assignments/ianaippmmetricsregistry-mib/ianaippmmetricsregistry-mib -O ${MIBS_DIR}/iana/IANA-IPPM-METRICS-REGISTRY-MIB
wget http://pastebin.com/raw/p3QyuXzZ -O ${MIBS_DIR}/ietf/SNMPv2-PDU
wget http://pastebin.com/raw/gG7j8nyk -O ${MIBS_DIR}/ietf/IPATM-IPMC-MIB

# Private MIBs


##
## Run service
##
service snmpd start && /bin/bash


exec "$@"
