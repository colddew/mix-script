#!/bin/sh
# single mongo
/usr/local/bin/mongod -config /usr/local/etc/mongod.conf

# mongo cluster

# replica sets
/usr/local/bin/mongod --dbpath /usr/local/var/mongodb --replSet repset
mongo --host <mongo-host> --port <mongo-port>
config = { _id:"repset", members:[
  {_id:0,host:"<mongo-host-1>:<mongo-port>"},
  {_id:1,host:"<mongo-host-2>:<mongo-port>"},
  {_id:2,host:"<mongo-host-1>:<mongo-port>"}]
}
rs.initiate(config);
rs.status();
db.getMongo().setSlaveOk();
rs.conf();

# monitor
/usr/local/bin/mongostat --host=<mongo-server-ip> --port=27017 5

# query
db.contactUserPhones.find({"createTime":{"$lt": new Date("2016-01-01T00:00:00.000+08:00")}}).count()

# export
mongoexport --host=127.0.0.1 --port=27017 -d db -c collection -o out.txt -q '{createTime:{$gte: new Date("2016-01-01T00:00:00.000+08:00"), $lt: new Date("2016-01-02T00:00:00.000+08:00")}}' -k --sort={"_id":1}

# sync
mongosync -h 127.0.0.1:27017 --to 127.0.0.1:27018 -d contact -c contactInfos --oplog

# command
mongo --host <mongo-host> --port <mongo-port>
show dbs;
use <db>;
show collections;
db.<collection>.count();
db.<collection>.find({});
db.currentOP();
db.version();
