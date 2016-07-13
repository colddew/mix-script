#!/bin/sh
# start cassandra
/Users/tools/cassandra/bin/cassandra -f

# kill cassandra
# ps aux | grep cassandra | grep -v grep | awk '{print $2}' | xargs kill -9
