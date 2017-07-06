#!/bin/bash
if [ -e /etc/init.d/zabbix-agent ];then
	echo 'zabbix-agent installed,exit..'
	exit
fi

ROLE=`whoami`
if test $# -ne 2;then
	echo 
	echo
	echo "	This script for installing saltminion on ubuntu14.04"
	echo "	Usage:"
	echo " 	$0 [zabbix_server_ip] [hostname]"
	echo
	exit
fi
if test $ROLE != "root";then
	echo 
	echo
	echo "This script should be run in root."
	echo "exit"
	echo
	exit
fi

echo 'install zabbix repo..'
yum -y install http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm  &> /dev/null
echo 'clean yum cache...'
yum clean all &>/dev/null
yum makecache &>/dev/null
echo 'install zabbix-agent...'
yum install zabbix-agent -y &>/dev/null

if test $? -eq 0;then 
	mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.default
	sed 's/Server=127.0.0.1/Server=$1/' /etc/zabbix/zabbix_agentd.default > /etc/zabbix/zabbix_agentd.conf
	sed -i "s/Hostname=.*/Hostname=$2/" /etc/zabbix/zabbix_agentd.conf
	service zabbix-agent start &>/dev/null
	echo 'Success installed zabbix-agent !!!'
else
	echo
	echo
	echo "Failed to install zabbix-agent."
	echo 
	exit
fi
