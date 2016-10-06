#!/bin/sh
# /Users/tools/redis/src/redis-cli
#/Users/tools/redis/src/redis-cli -c -p 7000
/Users/tools/redis/src/redis-cli -c -h <remote-redis-server> -p 6390

# client command
cluster nodes
