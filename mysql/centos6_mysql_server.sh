#!/bin/bash
ROLE=`whoami`

if test $ROLE != "root";then
	echo 
	echo
	echo "This script should be run in root."
	echo "exit"
	echo
	exit
fi

echo 'install mysql repo...'
yum -y install https://dev.mysql.com/get/mysql57-community-release-el6-10.noarch.rpm &>/dev/null

echo 'clean yum cache...'
yum clean all &>/dev/null

yum makecache &>/dev/null

echo 'install mysql_server...'
yum -y install mysql-server &>/dev/null

if test $? -ne 0;then
	echo 
	echo "Failed to install mysql-server"
	echo "exit"
	exit
fi
echo 'Success installed mysql-server !'
exit

