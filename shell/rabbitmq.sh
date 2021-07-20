#!/bin/sh
# install rabbit on mac
brew install erlang
# erl
brew install rabbitmq

# enable rabbitmq management plugin
cd /usr/local/Cellar/rabbitmq/3.x.x/
sudo sbin/rabbitmq-plugins enable rabbitmq_management
sudo sbin/rabbitmq-plugins enable rabbitmq_web_stomp
sudo sbin/rabbitmq-plugins enable rabbitmq_web_stomp_examples

sudo vi /etc/profile
export RABBIT_HOME=/usr/local/Cellar/rabbitmq/3.8.0
export PATH=$PATH:$RABBIT_HOME/sbin
source /etc/profile

sudo rabbitmq-server -detached
sudo rabbitmqctl status
# http://127.0.0.1:15672/
# guest/guest
rabbitmqctl stop
