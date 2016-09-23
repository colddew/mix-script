#!/bin/sh
consul agent -data-dir /tmp/consul -node=<local-ip> -bind=<local-ip> -join=<remote-consul-server>
consul members
