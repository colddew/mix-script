#!/bin/sh
# start zookeeper
<zookeeper-home>/bin/zkServer.sh start <zookeeper-home>/conf/zoo.cfg &

# shutdown zookeeper
ps aux | grep zookeeper | grep -v grep | awk '{print $2}' | xargs kill -9
