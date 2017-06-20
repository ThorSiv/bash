#!/bin/bash
#bitmain devops
#chongjie.zhong


#此脚本用作读取ip地址列表，列表格式:
#
#web:1.1.1.1:ubuntu14
#mysqldb:2.2.2.2:centos6
#
#默认使用root用户密匙登录
#centos6 centos7 ubuntu14 ubuntu16
#init 
DIR=`pwd`
# Usage information
if [ -z $1 ] || [ $# != "1" ];then
  echo "Usage: $0 [ip list file]"
exit
fi

MASTER=$1
PORT=$2


#read iplist file and output salt roster file
for i in `cat $1`;do
  HOST=`echo  $i|awk -F: '{print $1}'`
  IP=`echo $i | awk -F: '{print $2}'`
  SYSTEM=`echo $i | awk -F: '{print $3}'`
  echo "$HOST:" >> roster
  echo "  host:  $IP" >> roster
  echo "  user:  root" >> roster
  salt-ssh -i --roster-file=roster $HOST cp.get_file $DIR/scripts/${SYSTEM}.sh /tmp 
  salt-ssh -i --roster-file=roster $HOST cmd.run "/tmp/$SYSTEM.sh $MASTER $PORT $HOST" &> /dev/null &
done