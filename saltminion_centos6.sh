#!/bin/bash

if test $# -ne 1;then 
	echo
	echo "Script for Install saltstack minion in Centos6"
	echo "Usage:"
	echo "		$0 [hostname]"
	echo
	exit
fi


yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-2015.8-3.el6.noarch.rpm
yum clean expire-cache
yum -y install salt-minion

if test $? -eq 0;then
	echo "master: 123.57.30.231" >> /etc/salt/minion
	echo "id: $1" >> /etc/salt/minion
	echo "master_port: 8899" >> /etc/salt/minion
else
	echo 
	echo 
	echo "Failed to install salt-minion."
	echo
	exit
fi
