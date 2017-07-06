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
if test $ROLE != 'root';then
	echo 'This script must be run by root!'
	echo 'exit'
	exit
fi

echo "remove python2-pycryptodomex"
rpm -e --nodeps python2-pycryptodomex &>/dev/null
echo $?

echo "install python-crypto"
yum -y install python-crypto &>/dev/null
echo $?

echo 'install saltstack repo...'
yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el6.noarch.rpm  &>/dev/null
echo $?
yum clean expire-cache    &>/dev/null

echo 'install salt-minion...'
yum -y install salt-minion &>/dev/null
echo $?

echo 'start salt-minionon'
service salt-minion restart &> /dev/null
service salt-minion restart &> /dev/null
service salt-minion restart &> /dev/null
service salt-minion restart &> /dev/null


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
