#!/bin/sh
# start zookeeper
<zookeeper-home>/bin/zkServer.sh start &

# shutdown zookeeper
ps aux | grep zookeeper | grep -v grep | awk '{print $2}' | xargs kill -9

# client
<zk-home>/bin/zkCli.sh -server 127.0.0.1:2181
ls /
create /zk_test my_data
get /zk_test
set /zk_test junk
get /zk_test
delete /zk_test

########## zookeeper cluster ##########
# start node
/usr/local/zookeeper/bin/zkServer.sh start /usr/local/zookeeper/conf/zk1.cfg &
/usr/local/zookeeper/bin/zkServer.sh start /usr/local/zookeeper/conf/zk2.cfg &
/usr/local/zookeeper/bin/zkServer.sh start /usr/local/zookeeper/conf/zk3.cfg &

# check node status
/usr/local/zookeeper/bin/zkServer.sh status /usr/local/zookeeper/conf/zk1.cfg
/usr/local/zookeeper/bin/zkServer.sh status /usr/local/zookeeper/conf/zk2.cfg
/usr/local/zookeeper/bin/zkServer.sh status /usr/local/zookeeper/conf/zk3.cfg

# stop & restart node
/usr/local/zookeeper/bin/zkServer.sh stop /usr/local/zookeeper/conf/zk2.cfg
/usr/local/zookeeper/bin/zkServer.sh restart /usr/local/zookeeper/conf/zk3.cfg

# client link to server
/usr/local/zookeeper/bin/zkCli.sh -server 127.0.0.1:2181
/usr/local/zookeeper/bin/zkCli.sh -server 127.0.0.1:2182
/usr/local/zookeeper/bin/zkCli.sh -server 127.0.0.1:2183

########## cluster config ##########
###### zk1 ##########
# /usr/local/zookeeper/conf/zk1.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/usr/local/zookeeper/zk1/data
dataLogDir=/usr/local/zookeeper/zk1/logs
clientPort=2181
server.1=127.0.0.1:2881:3881
server.2=127.0.0.1:2882:3882
server.3=127.0.0.1:2883:3883

# /usr/local/zookeeper/zk1/data/myid
1

# /usr/local/zookeeper/zk1/logs

########## zk2 ##########

# /usr/local/zookeeper/conf/zk2.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/usr/local/zookeeper/zk2/data
dataLogDir=/usr/local/zookeeper/zk2/logs
clientPort=2182
server.1=127.0.0.1:2881:3881
server.2=127.0.0.1:2882:3882
server.3=127.0.0.1:2883:3883

# /usr/local/zookeeper/zk2/data/myid
2

# /usr/local/zookeeper/zk2/logs

########## zk3 ##########

# /usr/local/zookeeper/conf/zk3.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/usr/local/zookeeper/zk3/data
dataLogDir=/usr/local/zookeeper/zk3/logs
clientPort=2183
server.1=127.0.0.1:2881:3881
server.2=127.0.0.1:2882:3882
server.3=127.0.0.1:2883:3883

# /usr/local/zookeeper/zk3/data/myid
3

# /usr/local/zookeeper/zk3/logs
