#!/bin/sh
# start rabbitmq
/Users/tools/rabbitmq/sbin/rabbitmq-server &

# stop rabbitmq
ps aux | grep rabbitmq | grep -v grep | awk '{print $2}' | xargs kill -9
