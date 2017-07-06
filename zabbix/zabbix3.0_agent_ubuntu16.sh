#!/bin/bash
if [ -e /etc/init.d/zabbix-agent ];then
	echo 'zabbix-agent installed,exit..'
	exit
fi
if test $# -ne 1;then
	echo 
	echo
	echo "	This script for installing saltminion on ubuntu14.04"
	echo "	Usage:"
	echo " 	$0 [zabbix_server_ip] [hostname]"
	echo
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

wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+xenial_all.deb &>/dev/null
dpkg -i zabbix-release_3.0-1+xenial_all.deb &>/dev/null
apt-get update &>/dev/null
apt-get update &>/dev/null
apt-get install -y salt-minion &>/dev/null


if test $? -ne 0;then 
	echo 
	echo
	echo "Failed to install salt-minion."
	echo "exit."
	echo
	exit
fi

echo "master: $1"    >> /etc/salt/minion
echo "id: $2" 			>> /etc/salt/minion
echo "master_port: 8899" 	>> /etc/salt/minion


service salt-minion restart