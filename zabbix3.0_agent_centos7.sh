#!/bin/bash
if test $# -ne 1;then
	echo 
	echo
	echo "	This script for installing saltminion on ubuntu14.04"
	echo "	Usage:"
	echo " 	$0 [zabbix_server_ip] [hostname]"
	echo
	exit
fi

yum -y install http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm &>/dev/null
yum clean all  &>/dev/null
yum makecache  &>/dev/null
yum install zabbix-agent -y  &>/dev/null

if test $? -eq 0;then 
	mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.default
	sed "s/Server=127.0.0.1/Server=$1/" /etc/zabbix/zabbix_agentd.default > /etc/zabbix/zabbix_agentd.conf
	sed -i "s/Hostname=Zabbix server/Hostname=$2/" /etc/zabbix/zabbix_agentd.conf
	service zabbix-agent start
else
	echo
	echo
	echo "Failed to install zabbix-agent."
	echo 
	exit
fi
