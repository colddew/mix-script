#!/bin/sh
# startup
# echo $1 | sudo -S /usr/local/mysql/bin/mysqld_safe &
sudo /usr/local/mysql/bin/mysqld_safe &

# shutdown
ps aux | grep mysql | grep -v grep | awk '{print $2}' | xargs sudo kill -9
