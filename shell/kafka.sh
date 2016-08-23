#!/bin/sh
# start kafka server cluster
/Users/tools/kafka/bin/kafka-server-start.sh /Users/tools/kafka/config/server.properties
/Users/tools/kafka/bin/kafka-server-start.sh /Users/tools/kafka/config/cluster/server-1.properties
/Users/tools/kafka/bin/kafka-server-start.sh /Users/tools/kafka/config/cluster/server-2.properties

# create topic
/Users/tools/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic microservice-cluster

# delete topic
/Users/tools/kafka/bin/kafka-topics.sh --delete -zookeeper localhost:2181 --topic microservice-cluster

# list topic
/Users/tools/kafka/bin/kafka-topics.sh --list --zookeeper localhost:2181

# send message
/Users/tools/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic microservice-cluster

# receive message
/Users/tools/kafka/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic microservice-cluster --from-beginning

# describe broker
/Users/tools/kafka/bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic microservice-cluster

# query consumer stastics by given group and topic
/Users/tools/kafka/bin/kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --group microservice-group --topic microservice-topic --zookeeper localhost:2181
