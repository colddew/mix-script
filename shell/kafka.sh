#!/bin/sh
# start kafka server cluster
nohup <kafka-home>/bin/kafka-server-start.sh <kafka-home>/config/cluster/cluster-server-1.properties &
nohup <kafka-home>/bin/kafka-server-start.sh <kafka-home>/config/cluster/cluster-server-2.properties &
nohup <kafka-home>/bin/kafka-server-start.sh <kafka-home>/config/cluster/cluster-server-3.properties &

# shutdown kafka server cluster
# ps aux | grep kafka | grep -v grep | awk '{print $2}' | xargs kill -9

# create topic
# <kafka-home>/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic microservice-cluster

# delete topic
# <kafka-home>/bin/kafka-topics.sh --delete -zookeeper localhost:2181 --topic microservice-cluster

# list topic
# <kafka-home>/bin/kafka-topics.sh --list --zookeeper localhost:2181

# send message
# <kafka-home>/bin/kafka-console-producer.sh --broker-list localhost:9991 --topic microservice-cluster

# consume message
# <kafka-home>/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic microservice-cluster --from-beginning

# describe topic
# result line gives a summary of all the partitions
# each additional line gives information about one partition
# <kafka-home>/bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic microservice-cluster

# query consumer stastics by given group and topic
# <kafka-home>/bin/kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --group microservice-group --topic microservice-topic --zookeeper localhost:2181

# group operation
# <kafka-home>/bin/kafka-consumer-groups.sh --describe --group microservice-group --zookeeper localhost:2181
# <kafka-home>/bin/kafka-consumer-groups.sh --list --zookeeper localhost:2181
