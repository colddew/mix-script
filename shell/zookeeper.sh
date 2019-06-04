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
