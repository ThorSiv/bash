#!/bin/bash

if test $# -ne 1;then
	echo 
	echo
	echo "	This script for installing saltminion on ubuntu14.04"
	echo "	Usage:"
	echo " 	$0 [hostname]"
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

wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get update
apt-get install -y salt-minion

if test $? -ne 0;then 
	echo 
	echo
	echo "Failed to install salt-minion."
	echo "exit."
	echo
	exit
fi

echo "master: 123.57.30.231"    >> /etc/salt/minion
echo "id: $1" 			>> /etc/salt/minion
echo "master_port: 8899" 	>> /etc/salt/minion


service salt-minion restart
