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
if [ -z $1 ] || [ $# != "3" ];then
  echo "Usage: $0 [ip list file] [salt-master ip] [salt-master port]"
exit
fi

MASTER=$2
PORT=$3


#read iplist file and output salt roster file
for i in `cat $1`;do
  HOST=`echo  $i|awk -F: '{print $1}'`
  IP=`echo $i | awk -F: '{print $2}'`
  SYSTEM=`echo $i | awk -F: '{print $3}'`
  echo "$HOST:" >> roster
  echo "  host:  $IP" >> roster
  echo "  user:  root" >> roster
  salt-ssh -i --roster-file=roster $HOST cp.get_file $DIR/scripts/${SYSTEM}.sh /tmp 
  salt-ssh -i --roster-file=roster $HOST cmd.run "bash /tmp/$SYSTEM.sh $MASTER $PORT $HOST" &> /dev/null &
done



echo 'Done! Waite for the end. 5 minutes or 10 minutes'
echo 'you can run command :'
echo '--------( salt-ssh --roster-file=roster '*' cmd.run 'ps -ef|grep SYSTEM.sh'
echo 'to check whether jobs finished.'
