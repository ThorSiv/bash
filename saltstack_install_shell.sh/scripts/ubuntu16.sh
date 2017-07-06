#!/bin/bash
if [ -e /etc/init.d/salt-minion ];then
	echo 'salt-minion installed,exit...'
	exit
fi 
if test $# -ne 3;then 
	echo
	echo "Script for Install saltstack minion in Centos6"
	echo "Usage:"
	echo "		$0 [salt-master-ip]  [master-port]   [minion-hostname]"
	echo
	exit
fi

MASTER=$1
PORT=$2
HOSTNAME=$3
ROLE=`whoami`

if test $ROLE != "root";then
	echo 
	echo
	echo "This script should be run in root."
	echo "exit"
	echo
	exit
fi
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get update
apt-get install -y salt-minion

if test $? -eq 0;then
	echo "master: $MASTER" >> /etc/salt/minion
	echo "id: $HOSTNAME" >> /etc/salt/minion
	echo "master_port: $PORT" >> /etc/salt/minion
else
	echo 
	echo 
	echo "Failed to install salt-minion."
	echo 
	exit
fi

 systemctl restart salt-minion
 systemctl restart salt-minion
 systemctl restart salt-minion
 systemctl restart salt-minion
