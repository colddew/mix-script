#!/bin/sh
# start cluster
cd /Users/tools/redis/cluster/7000
./redis-server redis.conf
cd /Users/tools/redis/cluster/7001
./redis-server redis.conf
cd /Users/tools/redis/cluster/7002
./redis-server redis.conf
cd /Users/tools/redis/cluster/7003
./redis-server redis.conf
cd /Users/tools/redis/cluster/7004
./redis-server redis.conf
cd /Users/tools/redis/cluster/7005
./redis-server redis.conf

# kill cluster
# ps aux | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9

# start stand-alone in 6379 port
# nohup /Users/tools/redis/src/redis-server &
