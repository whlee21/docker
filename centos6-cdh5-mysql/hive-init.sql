CREATE DATABASE metastore;

CREATE USER 'hive'@'metastore' IDENTIFIED BY 'hive123';

GRANT ALL ON metastore.* TO 'hive'@'metastore';

FLUSH PRIVILEGES;
