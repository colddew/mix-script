#!/bin/sh
# start mongo
/usr/local/bin/mongod -config /usr/local/etc/mongod.conf

# monitor
mongostat --host=<mongo-server-ip> --port=27017 0 5
