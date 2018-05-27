#!/bin/sh
# consul server cluster
ip addr show docker0
# /etc/default/docker
DOCKER_OPTS="--dns 172.17.0.1 --dns 8.8.8.8 --dns-search service .consul"
service docker restart
docker run -d -h larry -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 53:53/udp --name larry_agent consul -server -advertise 101.132.146.94 -bootstrap-expect 2
docker run -d -h curly -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 53:53/udp --name curly_agent consul -server -advertise 122.152.199.200 -join 101.132.146.94
docker logs larry_agent
docker logs curely_agent
# http://101.132.146.94:8500
# http://localhost:8500/v1/health/service/consul?pretty
dig @localhost -p 8600 consul.service.consul

# consul server agent and client agent
docker run -d -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 53:53/udp -e CONSUL_UI_BETA=true -h node1 --name node1 consul agent -server -bootstrap-expect=1 -node=node1 -client 0.0.0.0 -ui -datacenter=dc1
# JOIN_IP="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' node1)"
docker run -d --name client1 -h client1 consul agent -node=client1 -join 172.17.0.2 -datacenter=dc1
docker run -d --name client2 -h client2 consul agent -node=client2 -join 172.17.0.2 -datacenter=dc1

# consul agent
consul agent -data-dir /tmp/consul -node=<local-ip> -bind=<local-ip> -join=<remote-consul-server>
consul members
