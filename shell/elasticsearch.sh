#!/bin/sh
# start elasticsearch
/Users/tools/es-cluster/es-node1/bin/elasticsearch -d
/Users/tools/es-cluster/es-node2/bin/elasticsearch -d
/Users/tools/es-cluster/es-node3/bin/elasticsearch -d

# start kibana
# /Users/tools/kibana/bin/kibana

# shutdown
# ps aux | grep elasticsearch | grep -v grep | awk '{print $2}' | xargs kill -9

# install plugin
# /Users/tools/es-cluster/es-node1/bin/plugin install mobz/elasticsearch-head
# 127.0.0.1:9201/_plugin/head/
