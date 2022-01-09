#!/bin/sh
# terminology
Relational DB -> Databases -> Tables -> Rows -> Columns
Elasticsearch -> Indices   -> Types  -> Documents -> Fields

# install es
useradd elasticsearch
chown -R elasticsearch:elasticsearch /usr/local/elasticsearch
su - elsearch
/usr/local/elasticsearch/bin/elasticsearch -d
http://localhost:9200/
curl http://localhost:9200/_cat/health

# start es cluster
/<es-path>/es-cluster/es-node1/bin/elasticsearch -d
/<es-path>/es-cluster/es-node2/bin/elasticsearch -d
/<es-path>/es-cluster/es-node3/bin/elasticsearch -d

# shutdown elasticsearch
# ps aux | grep elasticsearch | grep -v grep | awk '{print $2}' | xargs kill -9

# install es plugin
# cluster manager
# /<es-path>/es-cluster/es-node1/bin/plugin install mobz/elasticsearch-head
# http://localhost:9201/_plugin/head/

# /<es-path>/es-cluster/es-node1/bin/plugin install license
# /<es-path>/es-cluster/es-node1/bin/plugin install marvel-agent
# /<es-path>/es-cluster/es-node2/bin/plugin install license
# /<es-path>/es-cluster/es-node2/bin/plugin install marvel-agent
# /<es-path>/es-cluster/es-node3/bin/plugin install license
# /<es-path>/es-cluster/es-node3/bin/plugin install marvel-agent
# /<kibana-path>/kibana/bin/kibana plugin --install elasticsearch/marvel/2.3.5
# http://localhost:5601/app/kibana
# http://localhost:5601/app/marvel

# /<es-path>/es-cluster/es-node1/bin/plugin install elasticsearch/watcher/latest
# /<es-path>/es-cluster/es-node2/bin/plugin install elasticsearch/watcher/latest
# /<es-path>/es-cluster/es-node3/bin/plugin install elasticsearch/watcher/latest
# http://localhost:9201/_watcher/stats?pretty

# /<es-path>/es-cluster/es-node1/bin/plugin install lmenezes/elasticsearch-kopf
# http://localhost:9201/_plugin/kopf

# useful url
curl -X<VERB> '<PROTOCOL>://<HOST>:<PORT>/<PATH>?<QUERY_STRING>' -d '<BODY>'
?pretty
_cluster/health
_count
<index-name>/_search?pretty
_search?q=last_name:Smith
_cluster/stats
# _cluster/stats?human&pretty
_nodes/stats/jvm
_cat/nodes
_template
_cat/indices?v

# analyzer
# ik
# pinyin
elasticsearch-plugin install <analyzer-url>

# index curd
curl -XGET 'localhost:9200/<index>/user/1?pretty'
curl -XGET 'localhost:9200/<index>/user/_search?q=last_name:ya&pretty'

curl -XPUT  'localhost:9200/<index>/user/1?pretty' -H 'Content-Type: application/json' -d' {
	"first_name": "zhang",
	"last_name" : "ya",
	"age" : 18,
	"about" : "I like to collect rock albums", "interests": [ "music" ]
}'

curl -XPOST 'localhost:9200/<index>/user/1?pretty' -H 'Content-Type: application/json' -d' {
    "age" : 29
}

curl -XDELETE 'localhost:9200/<index>/user/1?pretty'

# set index replicas
curl -XPUT 'localhost:9200/<index>/_settings?pretty' -H 'Content-Type: application/json' -d' {
"settings" : { 
  "number_of_replicas" : 1
 } 
}'

# install logstash
# event processing pipeline has three stages: inputs → filters → outputs
# inputs generate events, filters modify them, and outputs ship them elsewhere
/<logstash-path>/logstash/bin/logstash -e 'input { stdin { } } output { stdout {} }'
/<logstash-path>/logstash/bin/logstash -e 'input{ stdin { } } output { stdout { codec=>rubydebug } }'
/<logstash-path>/logstash/bin/logstash agent -f /<logstash-path>/config/logstash.conf --configtest
/<logstash-path>/logstash/bin/logstash agent -f /<logstash-path>/config/logstash_agent.conf --configtest
/<logstash-path>/logstash/bin/logstash agent -f /<logstash-path>/config/logstash_indexer.conf --configtest

# logstash.conf
# input { stdin { } }
# output {
#   elasticsearch { hosts => ["localhost:9200"] }
#   stdout { codec => rubydebug }
# }
logstash -f logstash.conf
# logstash grok
grokdebug.herokuapp.com

# install filebeat
# filebeat.yml
# setup.template.settings:
#   index.number_of_shards: 3
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.16.2-linux-x86_64.tar.gz
tar xzvf filebeat-7.16.2-linux-x86_64.tar.gz
/<filebeat-path>/filebeat modules list
/<filebeat-path>/filebeat modules enable system nginx mysql
/<filebeat-path>/filebeat test config -e -c filebeat.yml
sudo chown root filebeat.yml 
sudo chown root modules.d/system.yml 
/<filebeat-path>/filebeat -e
/<filebeat-path>/filebeat -c filebeat.yml -e -d "*"
/<filebeat-path>/filebeat -e -c filebeat.yml

# install kibana
# config/kibana.yml
# elasticsearch.hosts=
nohup /<kibana-path>/kibana/bin/kibana &
http://localhost:5601

# intall elk with docker
# es single
docker network create elastic
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.16.2
docker run --name es01-test --net elastic -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.16.2
# docker cp ik <ik-plugins>:/usr/share/elasticsearch/plugins

docker pull docker.elastic.co/kibana/kibana:7.16.2
docker run --name kib01-test --net elastic -p 127.0.0.1:5601:5601 -e "ELASTICSEARCH_HOSTS=http://es01-test:9200" docker.elastic.co/kibana/kibana:7.16.2

# docker stop es01-test
# docker stop kib01-test
# docker network rm elastic
# docker rm es01-test
# docker rm kib01-test

# es cluster
# docker-compose.yml
docker-compose up
docker-compose up -d
docker-compose start
docker-compose down
docker-compose down -v
curl -X GET "localhost:9200/_cat/nodes?v=true&pretty"
docker-compose logs -f <service-name>

# configure system settings
# ulimit -a
# sudo su  
# ulimit -n 65535 
# su elasticsearch
# /etc/security/limits.conf
# elasticsearch  -  nofile  65535
# GET _nodes/stats/process?filter_path=**.max_file_descriptors

ulimit -u 4096
# /etc/security/limits.conf
# nproc 4096

# disable swap
# sudo swapoff -a
# elasticsearch.yml
# bootstrap.memory_lock: true
# GET _nodes?filter_path=**.mlockall

# virtual memory
# sysctl -w vm.max_map_count=262144
grep vm.max_map_count /etc/sysctl.conf
vm.max_map_count=262144
sysctl -p
sysctl vm.max_map_count

#sysctl -w net.ipv4.tcp_retries2=5
/etc/sysctl.conf
net.ipv4.tcp_retries2 5

# config es with docker
/usr/share/elasticsearch/config/

# docker images
# Dockerfile
# FROM docker.elastic.co/elasticsearch/elasticsearch:7.16.2
# COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/
docker build --tag=elasticsearch-custom .
docker run -it -v /usr/share/elasticsearch/data elasticsearch-custom

docker pull docker.elastic.co/kibana/kibana:7.16.2
# docker run -d -p 5601:5601 -e "ELASTICSEARCH_HOSTS=es01:9200" kibana:7.16.2
# http://localhost:5601

docker pull docker.elastic.co/logstash/logstash:7.16.2
docker run --rm -it -v ~/settings/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.16.2
docker run --rm -it -v ~/settings/logstash.yml:/usr/share/logstash/config/logstash.yml docker.elastic.co/logstash/logstash:7.16.2

# custom images
FROM docker.elastic.co/logstash/logstash:7.16.2
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/

docker pull docker.elastic.co/beats/filebeat:7.16.2
docker run docker.elastic.co/beats/filebeat:7.16.2 setup -E setup.kibana.host=kibana:5601 -E output.elasticsearch.hosts=["elasticsearch:9200"]

# custom images
FROM docker.elastic.co/beats/filebeat:7.16.2
COPY --chown=root:filebeat filebeat.yml /usr/share/filebeat/filebeat.yml