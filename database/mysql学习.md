# mysql学习
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
- SQL
    ```sql
    -- DATABASE
    ALTER  {DATABASE | SCHEMA} [db_name] [DEFAULT] CHARACTER SET [=] charset_name;
    CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] [db_name] [DEFAULT] CHARACTER SET [=] charset_name;
    DROP   {DATABASE | SCHEMA} [IF ExISTS] db_name;
    -- TABLE
    ALTER TABLE tb1_name
        | ADD [COLUMN] col_name column_definition
        | DROP [COLUMN] col_name
        | RENAME COLUMN old_col_name TO new_cl_name;
    DROP  [TEMPORARY] TABLE [IF EXISTS] tb1_name[, tb2_name] [RESTRICT | CASCADE];
    -- FUNCTION
    ALTER FUNCTION func_name COMMENT 'string'
        | LANGUAGE SQL 
        | {CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA}
        | SQL SECURITY {DEFINER | INVOKER};
    -- PROCEDURE
    ALTER PROCEDURE proce_name COMMENT 'string'
        | LANGUAGE SQL 
        | {CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA}
        | SQL SECURITY {DEFINER | INVOKER};
    -- VIEW
    ALTER [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
          [DEFINER = {user | CURRENT_USER}]
          [SQL SECURITY {DEFINER | INVOKER}]
          VIEW view_name [(column_list)]
          AS select_statement
          [WITH [CASCADED | LOCAL] CHECK OPTION];
    -- INDEX
    CREATE [UNIQUE | FULLTEXT | SPATIAL] INDEX index_name
        [index_type]
        ON tb1_name ({col_name [(length)] | (expr)} [ASC | DESC], ...)
        [KEY_BLOCK_SIZE [=] value | USING {BTREE | HASH}
        | WITH PARSER parser_name | comment 'string' | {VISIBLE | INVISIBLE}]
        [ALGORITHM [=] {DEFAULT | INPLACE | COPY} | LOCK [=] {DEFAULT | NONE | SHARED | EXCLUSIVE}]
    -- EVENT
    ALTER  [DEFINER = { user | CURRENT_USER}] EVENT event_name 
        [ON SCHEDULE schedule]
        [ON COMPLETION [NOT] PRESERVE]
        [RENAME TO new_event_name]
        [ENABLE | DISABLE | DISABLE ON SLAVE]
        [COMMENT 'string']
        [DO event_body];
    CREATE [DEFINER = { user | CURRENT_USER}] EVENT [IF NOT EXISTS] event_name
        [ON SCHEDULE schedule]
        [ON COMPLETION [NOT] PRESERVE]
        [RENAME TO new_event_name]
        [ENABLE | DISABLE | DISABLE ON SLAVE]
        [COMMENT 'string']
        [DO event_body];
    DROP   EVENT [IF EXISTS] event_name;
    -- privileges
    CREATE USER 'user'@'%' IDENTIFIED BY 'passowrd';
    GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' WITH GRANT OPTION;
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
    SHOW GRANTS FOR 'user'@'%';
    SHOW DATABASES;
    CREATE DATABSE pets;
    USE PETS;
    SHOW TABLES;
    DESCRIEBE cats;
    LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet [LINES TERMINATED BY '\r\n';
    QUIT;
    source filename;
    \. filename;
    SHOW VARIABLES;
    SHOW STATUS;
    ```
- 常用配置
  - 远程登入
    - 该表
      - update user set host = '%' where user = 'root';
    - 授权
      - CREATE USER 'china'@'%' IDENTIFIED WITH mysql_native_password BY 'chinese';
      - GRANT ALL PRIVILEGES ON *.* TO 'china'@'%' WITH GRANT OPTION;
      - FLUSH PRIVILEGES;
  - 通用日志
    - ubuntu
      - 改文件/etc/apparmor.d/usr.sbin.mysqld