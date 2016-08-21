#!/bin/sh
# terminology
Relational DB -> Databases -> Tables -> Rows -> Columns
Elasticsearch -> Indices   -> Types  -> Documents -> Fields

# start elasticsearch
/Users/tools/es-cluster/es-node1/bin/elasticsearch -d
/Users/tools/es-cluster/es-node2/bin/elasticsearch -d
/Users/tools/es-cluster/es-node3/bin/elasticsearch -d

# start kibana
/Users/tools/kibana/bin/kibana

# shutdown
# ps aux | grep elasticsearch | grep -v grep | awk '{print $2}' | xargs kill -9

# install plugin
# /Users/tools/es-cluster/es-node1/bin/plugin install mobz/elasticsearch-head
# http://localhost:9201/_plugin/head/

# /Users/tools/es-cluster/es-node1/bin/plugin install license
# /Users/tools/es-cluster/es-node1/bin/plugin install marvel-agent
# /Users/tools/es-cluster/es-node2/bin/plugin install license
# /Users/tools/es-cluster/es-node2/bin/plugin install marvel-agent
# /Users/tools/es-cluster/es-node3/bin/plugin install license
# /Users/tools/es-cluster/es-node3/bin/plugin install marvel-agent
# /Users/tools/kibana/bin/kibana plugin --install elasticsearch/marvel/2.3.5
# http://localhost:5601/app/kibana
# http://localhost:5601/app/marvel

# /Users/tools/es-cluster/es-node1/bin/plugin install elasticsearch/watcher/latest
# /Users/tools/es-cluster/es-node2/bin/plugin install elasticsearch/watcher/latest
# /Users/tools/es-cluster/es-node3/bin/plugin install elasticsearch/watcher/latest
# http://localhost:9201/_watcher/stats?pretty

# useful url
curl -X<VERB> '<PROTOCOL>://<HOST>:<PORT>/<PATH>?<QUERY_STRING>' -d '<BODY>'
?pretty
_cluster/health
_count
_search?q=last_name:Smith
_cluster/stats
_nodes/stats/jvm

# logstash
# event processing pipeline has three stages: inputs → filters → outputs
# inputs generate events, filters modify them, and outputs ship them elsewhere
/Users/tools/logstash/bin/logstash -e 'input { stdin { } } output { stdout {} }'
/Users/tools/logstash/bin/logstash agent -f /Users/script/shell/logstash.conf --configtest
