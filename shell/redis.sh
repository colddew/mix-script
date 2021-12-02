#!/bin/sh
# install stand-alone
curl -O http://download.redis.io/releases/redis-6.x.x.tar.gz
tar xzf redis-6.x.x.tar.gz
cd redis-6.x.x
make

# start stand-alone in 6379 port
# nohup <redis-home>/src/redis-server [redis.conf] &

# config cluster
mkdir -p /usr/local/redis/cluster/700{0..5}
mkdir -p /usr/local/redis/data/700{0..5}
mkdir /usr/local/redis/logs
cp /usr/local/redis/redis.conf /usr/local/redis/cluster/7000
cp /usr/local/redis/redis.conf /usr/local/redis/cluster/7001
cp /usr/local/redis/redis.conf /usr/local/redis/cluster/7002
cp /usr/local/redis/redis.conf /usr/local/redis/cluster/7003
cp /usr/local/redis/redis.conf /usr/local/redis/cluster/7004
cp /usr/local/redis/redis.conf /usr/local/redis/cluster/7005
# config redis.conf
# bind 127.0.0.1
protected-mode no
daemonize yes
port 7000
cluster-enabled yes
cluster-config-file nodes-7000.conf
cluster-node-timeout 15000
appendonly yes
appendfilename "appendonly.aof"
appendfsync everysec
pidfile /var/run/redis-7000.pid
loglevel notice
logfile "/usr/local/redis/logs/7000.log"
dir /usr/local/redis/data/7000/
masterauth xxx
requirepass xxx

# start node
/usr/local/redis/src/redis-server /usr/local/redis/cluster/7000/redis.conf
/usr/local/redis/src/redis-server /usr/local/redis/cluster/7001/redis.conf
/usr/local/redis/src/redis-server /usr/local/redis/cluster/7002/redis.conf
/usr/local/redis/src/redis-server /usr/local/redis/cluster/7003/redis.conf
/usr/local/redis/src/redis-server /usr/local/redis/cluster/7004/redis.conf
/usr/local/redis/src/redis-server /usr/local/redis/cluster/7005/redis.conf

# install depedencies
# brew install ruby
# brew install rubygems
# gem install redis

# install cluster before redis 5
# <redis-home>/src/redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005
# <redis-home>/src/redis-trib.rb check 127.0.0.1:7000

# install cluster after redis 5
# open 7000-7005 & 17000-17005 port
# /usr/local/redis/src/redis-cli -a x --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 --cluster-replicas 1
/usr/local/redis/src/redis-cli -a x --cluster create <public-ip>:7000 <public-ip>:7001 <public-ip>:7002 <public-ip>:7003 <public-ip>:7004 <public-ip>:7005 --cluster-replicas 2

# check cluster
ps aux | grep redis
netstat -tnlp | grep redis
/usr/local/redis/src/redis-cli --cluster check x.x.x.x:7000

# shutdown cluster
/usr/local/redis/src/redis-cli -a xxx -c -h x.x.x.x -p 700* shutdown

# delete node
/usr/local/redis/src/redis-cli --cluster del-node <ip>:<port> <node-id>

# kill cluster
# ps aux | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9

# client connect
# <redis-home>/src/redis-cli
# <redis-home>/src/redis-cli -c -p 7000
<redis-home>/src/redis-cli -c -h <remote-redis-server> -p 7000

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

# redis lock
SET lock-key "" EX 10 NX

# solve more than max connection count question
ss | grep 6379 | wc -l
info clients
client list
config get maxclients
config get timeout
config get tcp-keepalive
config get maxmemory
config set tcp-keepalive 60
config set timeout 300

# common command
info
dbsize
flushall
flushdb
memory usage <key>
select <database>

# batch handler
#!/bin/sh
host=$1
port=$2
password=$3
cat command.txt | /path/to/redis-cli -h $host -p $port -a $password --pipe

# batch delete
redis-cli -a xxx keys "feed:rank:*" | xargs redis-cli -a xxx del
./redis-cli -a <password> -n <db> keys "feed:count:stockChart*" | xargs ./redis-cli -a <password> -n <db> del

# calculate hash slot
cluster keyslot <key>
cluster keyslot {hash_tag}
# redis-memory-for-key -s <ip> -p <port> -a <password> -d 0 <key>

# calculate key length
MEMORY USAGE <key>
