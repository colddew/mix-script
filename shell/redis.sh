#!/bin/sh
# install stand-alone
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
tar xzf redis-5.0.5.tar.gz
cd redis-5.0.5
make

# start stand-alone in 6379 port
# nohup <redis-home>/src/redis-server &

# config cluster
# config cluster redis.conf
daemonize yes
port 9001
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes

# start node
cd <redis-conf>/cluster/7000 && <redis-home>/src/redis-server redis.conf
cd <redis-conf>/cluster/7001 && <redis-home>/src/redis-server redis.conf
cd <redis-conf>/cluster/7002 && <redis-home>/src/redis-server redis.conf
cd <redis-conf>/cluster/7003 && <redis-home>/src/redis-server redis.conf
cd <redis-conf>/cluster/7004 && <redis-home>/src/redis-server redis.conf
cd <redis-conf>/cluster/7005 && <redis-home>/src/redis-server redis.conf

# install depedencies
# brew install ruby
# brew install rubygems
# gem install redis

# install cluster
<redis-home>/src/redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005
<redis-home>/src/redis-trib.rb check 127.0.0.1:7000

# kill cluster
# ps aux | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9

# client connect
# <redis-home>/src/redis-cli
# <redis-home>/src/redis-cli -c -p 7000
<redis-home>/src/redis-cli -c -h <remote-redis-server> -p 6390

# cluster info
cluster nodes
cluster info

# max connect quantity
redis-cli -c -p 7000 config get maxclients
# 1) "maxclients"
# 2) "10000"

# used connect quantity
redis-cli -c -p 7000 info | grep conn
# connected_clients:1
# total_connections_received:8
# rejected_connections:0
# connected_slaves:0

# client commond
set foo bar
get foo
setex foo 30 bar
del foo