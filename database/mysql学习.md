# mysql学习
- 常用SQL
    ```sql
    -- Mysql特定语法
        -- 批量插入
        INSERT INTO tbl_name(a, b, c) VALUES (v11, v12, v13), (v21, v22, v23), (v31, v32, v33);
        -- 批量更新
        REPLACE INTO tbl_name(a, b, c) VALUES (v11, v12, v13), (v21, v22, v23), (v31, v32, v33);
        UPDATE yoiurtable
            SET dingdan = CASE id 
                WHEN 1 THEN 3 
                WHEN 2 THEN 4 
                WHEN 3 THEN 5 
            END
        WHERE id IN (1,2,3)
    -- 远程登入
        -- 更改root默认密码
        ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
        -- 允许远程
        UPDATE mysql.user SET host = '%' WHERE user = 'root'; 
        -- 授权
        CREATE USER 'china'@'%' IDENTIFIED BY 'chinese';
        GRANT ALL PRIVILEGES ON *.* TO 'china'@'%' WITH GRANT OPTION;
        FLUSH PRIVILEGES;
    -- 锁
        -- 隔离级别
            -- READ UNCOMMITTED
            -- READ COMMITTED
            -- REPEATABLE READ next-key locks 短时间批量insert update 会出现死锁, 可降级为READ COMMITTED
            -- SERIALIZABLE
        -- 查看 / 设置事务
            SELECT @@GLOBAL.TX_ISOLATION
            SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;
        -- 锁参数、信息查询
            SHOW VARIABLES LIKE '%lock%';
            SHOW VARIABLES like '%timeout%';
            SHOW STATUS LIKE '%lock%';
        -- 死锁查询
            -- 查看当前语句
                SHOW PROCESSLIST;
            -- 杀死进程
                KILL PID;
            -- 展示当前正在使用的表
                SHOW OPEN TABLES WHERE IN_USE > 0;
            -- 释放锁
                UNLOCK TABLES
            -- INNODB查看最近死锁日志
                SHOW ENGINE INNODB STATUS;
            -- group by 构造带主键的临时表, 设置临时表内存大小，导致是否使用磁盘
                set tmp_table_size=16 * 1024;
    -- mysql字符大小写不敏感
        SHOW COLLATION WHERE CHARSET='utf8mb4';
        -- 建表指定collation
        CREATE TABLE `table1` (
            `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
            `field1` text COLLATE utf8mb4_0900_bin NOT NULL COMMENT '字段1',
            `field2` varchar(128) COLLATE utf8mb4_0900_bin NOT NULL DEFAULT '' COMMENT '字段2',
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_bin;
        -- 查询的时候使用binary
        SELECT * FROM t_table WHERE BINARY name = '';
    -- 常用语句
        -- 查看建表语句
            SHOW CREATE TABLE test;
        -- 配置GROUP_CONCAT最大长度
            SET GLOBAL group_concat_max_len=512000;
    ```
- 锁
    - 锁粒度(有大到小)
        - 表级锁(Table-Level)
        - 页面锁(Page-Level)
        - 行级锁(Row-Level)
    - 锁类型
        - 共享锁(S, Share Lock)
        - 排他锁(X, Exclusive Lock) (INSERT、UPDATE、DELETE)
    - 存储引擎
        - MyISAM(表级锁, 写串行, 不支持事物)
            - 表共享读锁(Table Read Lock, 优先级低) (SELECT)
            - 表独占写锁(Table Write Lock, 优先级高) (INSERT、UPDATE、DELETE)
        - InnoDB(行级锁, 支持事物)
            - 行级级
                - 主键锁(Record Lock, 记录) LOCK_REC_NOT_GAP lock_mode X locks rec but not gap 
                - 间隙锁(Gap Lock, 索引区间[开区间])  LOCK_GAP lock_mode X locks gap before rec
                - 临键锁(Next-key Lock, record lock + gap lock[左开右闭区间]) LOCK_ORDINARY lock_mode X
            - 表级锁
                - 意向共享锁(IS, Intention Share Lock)
                - 意向排他锁(IX, Intention Exclusive Lock) LOCK_INSERT_INTENTION lock_mode X locks gap before rec insert intention
                - 自增锁(Auto-inc Lock)
  - Data Type
    - Numeric
        - BIT
        - TINYINT [UNSIGNED] [ZEROFILL]
        - BOOL BOOLEAN
        - SMALLINT [UNSIGNED] [ZEROFILL] (2bytes)
        - MEDIUMINT [UNSIGNED] [ZEROFILL] (3bytes)
        - INT / INTEGER [UNSIGNED] [ZEROFILL] (4bytes)
        - BIGINT [UNSIGNED] [ZEROFILL] (8bytes)
        - DECIMAL[(M[,D])] / DEC[(M[,D])] / NUMERIC[(M[,D])] [UNSIGNED] [ZEROFILL]
        - FLOAT[(M[,D])] [UNSIGNED] [ZEROFILL]
        - DOUBLE[(M[,D])] / DOUBLE_PRECISION[(M[,D])] [UNSIGNED] [ZEROFILL]
    - Date
        - DATE (1000-01-01 -- 9999-12-31)
        - DATETIME(1000-01-01 00:00:00.000000 -- 9999-12-31 23:59::59.999999) (4 bytes)
        - TIMESTAMP(1970-01-01 00:00:00.000000 -- 2038-01-19 03:14:07.999999)
        - TIME(-838:59:59.000000 -- 838:59:59.000000)
        - YEAR[(4)]
    - String
        - CHAR [CHARACTER SET charset_name] [COLLATE collation_name]
        - VARCHAR [CHARACTER SET charset_name] [COLLATE collation_name]
        - BINARY
        - TINYBLOB / BLOB / MEDIUMBLOB / LONGBLOB
        - TINYTEXT(255B) / TEXT(64KB) / MEDIUMTEXT(16MB) / LONGTEXT(4GB)
        - ENUM('value1', 'value2', ...) [CHARACTER SET charset_name]
        - SET('value1', 'value2', ...) [CHARACTER SET charset_name]