#!/bin/bash

# at
at now + 30 minutes
# command
# ctrl + D
atq
atrm <command id>

# cron
service crond start
service crond status
crontab -e
# 0/1 * * * * <command>
crontab -l
crontab -r

# batch
for i in `cat ids.txt`
do
  echo id is $i
  curl -X GET --header "Accept: */*" --header "Authorization: XXX" "http://localhost:8080/api/$i/rebuild"
done
