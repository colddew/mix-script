#!/bin/sh
# startup
# echo $1 | sudo -S /usr/local/mysql/bin/mysqld_safe
sudo /usr/local/mysql/bin/mysqld_safe

# shutdown
ps aux | grep mysql | grep -v grep | awk '{print $2}' | xargs sudo kill -9

# assign remote access privilege
GRANT ALL ON *.* to root@'192.168.xxx.xxx' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;

# SET NAMES 'utf8mb4';  
# SET character_set_client = utf8mb4;  
# SET character_set_results = utf8mb4;   
# SET character_set_connection = utf8mb4;

# SHOW VARIABLES LIKE 'character%';
SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';

# change character set to utf8mb4
ALTER DATABASE succulent CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
ALTER TABLE T_Succulent_User CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE T_Succulent_User CHANGE NickName NickName varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'XXX';

# mycli
mycli <database-name>

# slow query
/usr/bin/mysql -uroot -p
SELECT VERSION();
SHOW VARIABLES LIKE '%slow_query_log%';
# SET GLOBAL slow_query_log=1;
SHOW GLOBAL VARIABLES LIKE '%long_query_time%';
SET GLOBAL long_query_time=1;
SHOW GLOBAL STATUS LIKE '%Slow_queries%';
mysqldumpslow -s r -t 10 slow.log
mysqldumpslow -s t -t 10 -g "left join" slow.log
# permanent
# /etc/my.conf
slow_query_log=ON
slow_query_log_file=/mysql/slow.log
long_query_time=1

# deadlock
show status like '%lock%';
show processlist;
# kill <process-id>

select @@tx_isolation;
select @@autocommit;

SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCKS;
SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCK_WAITS;
SELECT * FROM information_schema.INNODB_TRX;

select r.trx_id wait_trx_id, r.trx_mysql_thread_id wait_thr_id, r.trx_query wait_query, b.trx_id block_trx_id, b.trx_mysql_thread_id block_thrd_id, b.trx_query block_query from information_schema.innodb_lock_waits w inner join information_schema.innodb_trx b on b.trx_id = w.blocking_trx_id inner join information_schema.innodb_trx r on r.trx_id = w.requesting_trx_id;

-- innodb_print_all_deadlocks  = ON
-- innodb_status_output_locks = ON

SELECT CONCAT_WS('','kill',' ',t.trx_mysql_thread_id,';')a FROM information_schema.INNODB_TRX t;
-- kill <trx_mysql_thread_id>

-- InnoDB Standard Monitor and Lock Monitor Output
show engine innodb status;
select @@log_error;
show warnings;

# sql_mode
select @@global.sql_mode;
-- set @@global.sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
set @@global.sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

# binlog
# cat /mysql/path/my.cnf
# [mysqld]
# log-bin=mysql-bin
# binlog-format=ROW
# server_id=1
# binlog-do-db=<db-name>
mysqlbinlog --no-defaults mysql-bin.000001
show variables like 'binlog_format';
show variables like 'log_bin';
# set sql_log_bin=1
# set sql_log_bin=0
show binary logs;
show master status;
show master logs;
show binlog events;
show binlog events in <binlog-name>;
show variables like 'expire_logs_days';
# set global expire_logs_days=7;
# flush logs;

# yum install mysql 5.7 on centos 7
service mysqld start
service mysqld stop
service mysqld restart
service mysqld status
cat /etc/my.cnf
# datadir=/var/lib/mysql
# socket=/var/lib/mysql/mysql.sock
# log-error=/var/log/mysqld.log
# pid-file=/var/run/mysqld/mysqld.pid

# export sql
mysqldump [-h <host>] -u root -p > <export>.sql
# import sql
mysql> source <import.sql>
mysql> select now() into outfile <import.sql>
mysql -u root -p -e "source <import.sql>"
mysql [-h <host>] -u root -p <databases> < <import.sql> > import.log

# canal deployer
# my.cnf
[mysqld]
log-bin=mysql-bin
binlog-format=ROW
server_id=1

show variables like 'binlog_format';
show variables like 'log_bin';

CREATE USER canal IDENTIFIED BY 'canal';
GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canal'@'%';
-- GRANT ALL PRIVILEGES ON *.* TO 'canal'@'%';
FLUSH PRIVILEGES;
# select * from mysql.user;
# show grants for canal;
# show privileges;
CREATE USER canal_admin IDENTIFIED BY 'canal_admin';
GRANT ALL PRIVILEGES ON canal_manager.* TO 'canal_admin'@'%';
FLUSH PRIVILEGES;

mkdir canal-deployer-1.1.5
tar -zxvf canal.deployer-1.1.5.tar.gz -C canal-deployer-1.1.5
<canal-deployer-path>/bin/startup.sh
<canal-deployer-path>/bin/startup.sh local
<canal-deployer-path>/bin/startup.sh debug 9099
<canal-deployer-path>/bin/stop.sh
tail -f <canal-deployer-path>/logs/canal/canal.log
tail -f <canal-deployer-path>/logs/example/example.log

# canal admin
# con/application.yml
# spring.datasource.address
# spring.datasource.username
# spring.datasource.password
<canal-admin-path>/bin/startup.sh
<canal-admin-path>/bin/stop.sh
# http://127.0.0.1:8089

# canal adapter
# download source and recompile client-adapter.es7x-1.1.5-jar-with-dependencies.jar
# conf/application.yml
# server.port
# canal.conf.consumerProperties.canal.tcp.server.host
# canal.conf.srcDataSources.defaultDS.url
# canal.conf.srcDataSources.defaultDS.username
# canal.conf.srcDataSources.defaultDS.password
# canal.conf.canalAdapters.groups.outerAdapters.hosts
# canal.conf.canalAdapters.groups.outerAdapters.properties.cluster.name
<canal-adapter-path>/bin/startup.sh
<canal-adapter-path>/bin/stop.sh
# curl http://127.0.0.1:8081/destinations
# curl -X PUT http://127.0.0.1:8081/syncSwitch/example/off
# curl http://127.0.0.1:8081/syncSwitch/example
# import partial data, etlCondition in yml
# curl -X POST http://127.0.0.1:8081/etl/hbase/mytest_person2.yml -d "params=2018-10-21 00:00:00"
# import all data
# curl -X POST http://127.0.0.1:8081/etl/hbase/mytest_person2.yml
# curl -X POST http://ip:8081/etl/es7/example.yml
# curl http://127.0.0.1:8081/count/hbase/mytest_person2.yml
