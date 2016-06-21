#!/bin/sh
consul agent -data-dir /tmp/consul -node=192.168.20.42 -bind=192.168.20.42 -join=10.0.40.122
