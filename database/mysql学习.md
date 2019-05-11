# mysql学习
- 常用配置
  - 远程登入
    - 改表
      - update user set host = '%' where user = 'root';
    - 授权
      ```sql
      CREATE USER 'china'@'%' IDENTIFIED WITH mysql_native_password BY 'chinese';
      GRANT ALL PRIVILEGES ON *.* TO 'china'@'%' WITH GRANT OPTION;
      FLUSH PRIVILEGES;
      ```
- Data Type
  - Numeric
    - BIT[(M)]
    - TINYINT[(M)] [UNSIGNED] [ZEROFILL]
    - BOOL BOOLEAN
    - SMALLINT[(M)] [UNSIGNED] [ZEROFILL] (2bytes)
    - MEDIUMINT[(M)] [UNSIGNED] [ZEROFILL] (3bytes)
    - INT[(M)] / INTEGER[(M)] [UNSIGNED] [ZEROFILL] (4bytes)
    - BIGINT[(M)] [UNSIGNED] [ZEROFILL] (8bytes)
    - DECIMAL[(M[,D])] / DEC[(M[,D])] / NUMERIC[(M[,D])] [UNSIGNED] [ZEROFILL]
    - FLOAT[(M[,D])] [UNSIGNED] [ZEROFILL]
    - DOUBLE[(M[,D])] / DOUBLE_PRECISION[(M[,D])] [UNSIGNED] [ZEROFILL]
  - Date
    - DATE (1000-01-01 -- 9999-12-31)
    - DATETIME[(fsp)] (1000-01-01 00:00:00.000000 -- 9999-12-31 23:59::59.999999)
    - TIMESTAMP[(fsp)] (1970-01-01 00:00:00.000000 -- 2038-01-19 03:14:07.999999)
    - TIME[(fsp)] (-838:59:59.000000 -- 838:59:59.000000)
    - YEAR[(4)]
  - String
    - CHAR[(M)] [CHARACTER SET charset_name] [COLLATE collation_name]
    - VARCHAR[(M)] [CHARACTER SET charset_name] [COLLATE collation_name]
    - BINARY[(M)]
    - TINYBLOB[(M)] / BLOB[(M)] / MEDIUMBLOB[(M)] / LONGBLOB
    - TINYTEXT[(M)] / TEXT[(M)] / MEDIUMTEXT[(M)] / LONGTEXT
    - ENUM('value1', 'value2', ...) [CHARACTER SET charset_name]
    - SET('value1', 'value2', ...) [CHARACTER SET charset_name]