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
SHOW ENGINE INNODB STATUS;
select @@log_error;

# sql_mode
select @@global.sql_mode;
-- set @@global.sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
set @@global.sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
