#!/bin/bash
if [ -e /etc/init.d/zabbix_agent ];then
	echo 'zabbix-agent installed,exit..'
	exit
fi
ROLE=`whoami`

if test $ROLE != "root";then
	echo 
	echo
	echo "This script should be run in root."
	echo "exit"
	echo
	exit
fi
if test $# -ne 1;then
	echo 
	echo
	echo "	This script for installing zabbix_agentd on ubuntu14.04"
	echo "	Usage:"
	echo " 	$0 [hostname]"
	echo
	exit
fi

wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb
dpkg -i zabbix-release_3.0-1+trusty_all.deb
apt-get update
apt-get update
apt-get install zabbix-agent

if test $? -eq 0;then 
	mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.default
	sed 's/Server=127.0.0.1/Server=101.200.210.206/' /etc/zabbix/zabbix_agentd.default > /etc/zabbix/zabbix_agentd.conf
	sed -i "s/Hostname=Zabbix server/Hostname=$1/" /etc/zabbix/zabbix_agentd.conf
	service zabbix-agent start
else
	echo
	echo
	echo "Failed to install zabbix-agent."
	echo 
	exit
fi
