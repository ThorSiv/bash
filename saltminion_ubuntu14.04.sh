#!/bin/bash

if test $# -ne 3;then
	echo 
	echo
	echo "	This script for installing saltminion on ubuntu14.04"
	echo "	Usage:"
	echo " 	$0 [saltstack_server_ip]  [server_port]  [hostname]"
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

wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add - &>/dev/null
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" > /etc/apt/sources.list.d/saltstack.list &>/dev/null
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
echo "id: $3" 			>> /etc/salt/minion
echo "master_port: $2" 	>> /etc/salt/minion


service salt-minion restart
if test $? -eq 0;then
	echo 'Success started salt-minion!!!'
else
	echo 'Failed to start salt_minion'
fi
