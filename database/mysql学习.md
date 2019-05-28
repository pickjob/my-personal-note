# mysql学习
- 常用SQL
    ```sql
    -- 远程登入
      -- 改表
      update user set host = '%' where user = 'root'; 
      -- 授权
      CREATE USER 'china'@'%' IDENTIFIED WITH mysql_native_password BY 'chinese';
      GRANT ALL PRIVILEGES ON *.* TO 'china'@'%' WITH GRANT OPTION;
      FLUSH PRIVILEGES;
    -- 批量插入
    INSERT INTO tbl_name(a, b, c) VALUES (v11, v12, v13), (v21, v22, v23), (v31, v32, v33);
    -- 批量更新
    replace into tbl_name(a, b, c) values (v11, v12, v13), (v21, v22, v23), (v31, v32, v33);
    -- 死锁查询
    show variables like 'innodb_lock_wait_timeout'
    show status like 'Innodb_row_lock%'
    ```
- 锁
  - 锁粒度(有大到小)
    - 表级锁(Table-Level)
    - 页面锁(Page-Level)
    - 行级锁(Row-Level)
  - 存储引擎
    - MyISAM(表级锁, 写串行, 不支持事物)
      - 表共享读锁(Table Read Lock, 优先级低) (SELECT)
      - 表独占写锁(Table Write Lock, 优先级高) (INSERT、UPDATE、DELETE)
    - InnoDB(行级锁, 支持事物)
      - 行级锁(索引实现)
        - 共享锁(S, Share Lock)
        - 排他锁(X, Exclusive Lock) (INSERT、UPDATE、DELETE)
      - 索引级
        - 间隙锁(Gap Lock, 唯一索引, 范围条件)
        - 临键锁(Next-key Lock, 非唯一索引锁)
      - 表级锁
        - 意向共享锁(IS, Intention Share Lock)
        - 意向排他锁(IX, Intention Exclusive Lock)
        - 自增锁(Auto-inc Lock)
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