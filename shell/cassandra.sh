#!/bin/sh
# start local cassandra in the foreground/background
# /Users/tools/cassandra/bin/cassandra -f
/Users/tools/cassandra/bin/cassandra

# query cassandra status
/Users/tools/cassandra/bin/nodetool status

# cqlsh
cqlsh localhost
# SELECT cluster_name, listen_address FROM system.local;

# kill cassandra
pgrep -f CassandraDaemon
kill pid
# pkill -f CassandraDaemon

# kill cassandra cluster
ps aux | grep cassandra | grep -v grep | awk '{print $2}' | xargs kill -9

#############################################
# install cassandra cluster by ccm
#############################################

# install dependency
python
java8
sudo easy_install pyYaml
sudo easy_install six
brew install ant
sudo pip install psutil

# config multiple loopback aliases
sudo ifconfig lo0 alias 127.0.0.2 up
sudo ifconfig lo0 alias 127.0.0.3 up
ifconfig lo0

# install ccm
sudo pip install ccm

# config HostName and ComputerName
scutil --get HostName
scutil --get ComputerName
scutil --set ComputerName XXX
scutil --set HostName XXX

# config hosts
echo "127.0.0.1 XXX" >> /etc/hosts

# start cassandra cluster by ccm
# /Users/colddew/.ccm
# ccm create test -v 2.2.8 -n 3 -s
# ccm create test --install-dir=<path/to/cassandra-sources>
ccm invalidatecache
ccm create test -v 2.2.8
ccm populate -n 3
ccm start
ccm stop

# query cassandra cluster status by ccm
ccm node1 show
ccm node1 status
ccm node1 ring
ccm node1 showlog
ccm list
ccm status
ccm flush
ccm node1 flush

# add node to cassandra cluster
ccm add node4 -i 127.0.0.4 -j 7400 -b

# flush cassandra cluster node
ccm flush
ccm node1 flush

# remove cassandra cluster
ccm remove

# ccm cqlsh
ccm node1 cqlsh
