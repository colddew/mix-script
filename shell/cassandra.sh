#!/bin/sh
# mkdir <cassandra-home>/logs
# mkdir -p <cassandra-home>/data/data
# chown -R <user>:<group> logs
# chown -R <user>:<group> data
# start local cassandra in the foreground/background
# <cassandra-home>/bin/cassandra -f
<cassandra-home>/bin/cassandra
<cassandra-home>/bin/cassandra -v

# query cassandra status
<cassandra-home>/bin/nodetool status

# cqlsh
cqlsh localhost port [-u username -p password]
# SELECT cluster_name, listen_address FROM system.local;
# desc keyspaces;
# CREATE KEYSPACE IF NOT EXISTS mykeyspace WITH replication = {'class' : 'SimpleStrategy','replication_factor' : 3};
# use mykeyspace;
# CREATE CUSTOM INDEX IF NOT EXISTS IDX_LASTNAME ON customers (lastName);
# CREATE TABLE customers (customerId uuid PRIMARY KEY, firstName text, lastName text);
# desc mykeyspace.customers;
# INSERT INTO customers (customerId,  firstName, lastName) VALUES (5127697b-1c12-4e0e-a70a-a23c1be65781, 'john', 'smith');
# SELECT cluster_name, listen_address FROM system.local;
# DROP TABLE IF EXISTS keyspace_name.table_name;
# DROP INDEX IF EXISTS keyspace.index_name

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
# ~/.ccm
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