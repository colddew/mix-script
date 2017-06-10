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
