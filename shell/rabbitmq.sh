#!/bin/sh
# start rabbitmq
/Users/tools/rabbitmq/sbin/rabbitmq-server &
/Users/tools/rabbitmq/sbin/rabbitmq-server restart &

# stop rabbitmq
ps aux | grep rabbitmq | grep -v grep | awk '{print $2}' | xargs kill -9

# 
http://127.0.0.1:15672/
guest/guest
