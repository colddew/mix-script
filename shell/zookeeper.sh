#!/bin/sh
# start zookeeper
/Users/tools/zookeeper/bin/zkServer.sh start /Users/tools/zookeeper/conf/zoo.cfg &

# shutdown zookeeper
ps aux | grep zookeeper | grep -v grep | awk '{print $2}' | xargs kill -9
