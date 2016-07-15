#!/bin/sh
# start local cassandra
# /Users/tools/cassandra/bin/cassandra -f
/Users/tools/cassandra/bin/cassandra

# query cassandra cluster status
/Users/tools/cassandra/bin/nodetool status

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
sudo ifconfig lo0 alias 127.0.0.2 up

# install ccm
sudo pip install ccm

# config HostName and ComputerName
scutil --get HostName
sutil --get ComputerName
scutil --set ComputerName XXX
scutil --set HostName XXX

# config hosts
echo "127.0.0.1 XXX" >> /etc/hosts

# start cassandra cluster by ccm
# /Users/colddew/.ccm
ccm invalidatecache
ccm create test -v 3.0.7 -n 3 -s

# query cassandra cluster status by ccm
ccm node1 nodetool status
ccm list
ccm status
ccm node1 ring
ccm node1 showlog
ccm flush
ccm node1 flush

# add node to cassandra cluster
ccm add node4 -i 127.0.0.4 -j 7400 -b

# flush cassandra cluster node
ccm flush
ccm node1 flush

# remove cassandra cluster
ccm remove
