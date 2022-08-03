# PostgreSQL学习
- 常用SQL
    ```sql
    export PGPASSWORD=
    
    -- update limit
    with updates as (
        select * FROM table_name limit 100000
    )
    update table_name t set col_a = 'new_val' from updates where t.col = updates.col;

    -- update insert
    with upsert as (
        update table_name set col_a = 'new_val'
        RETURNING *
    )
    insert into table_name
    select col_val where not exists  (select 1 from upsert);

    -- upsert
    INSERT INTO my_table (column1, column2)
    VALUES
        (value1, value2)
        ON CONFLICT <target> <action>;
            <target>: 
                    (col) Unique Key
            <action>:
                    DO UPDATE
            INSERT INTO director (id, name) VALUES(2, 'robert')
            ON CONFLICT (id) DO UPDATE
            SET name = EXCLUDED.name;

    -- PG一些限制
    max_locks_per_transaction:
        max_locks_per_transaction * (max_connections + max_prepared_transactions)
    max_pred_locks_per_transaction:
        max_pred_locks_per_transaction * (max_connections + max_prepared_transactions) 

    -- pg特殊配置
    zero_damaged_pages = true;

    -- 获取类型
    SELECT pg_typeof(variable);

    -- PG创建隐式转换
    -- 输入输出直接强转
    CREATE CAST (varchar AS integer) WITH INOUT AS IMPLICIT;
    -- 使用函数强转
    CREATE CAST (source_type AS target_type)
    WITH FUNCTION function_name (argument_type [, ...]) AS IMPLICIT;
    -- 删除强转
    DROP CAST IF EXISTS (varchar AS integer);
    CREATE FUNCTION to_char(bigint) RETURNS text
    AS 'select $1 || '''''
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT;

    -- 关闭触发器
    ALTER TABLE table_name DISABLE TRIGGER trigger_name;
    ALTER TABLE table_name ENABLE TRIGGER trigger_name;

    -- 聚合函数信息查询
    select * from pg_catalog.pg_aggregate where aggfnoid = (SELECT oid FROM pg_proc WHERE proname = 'agg_proc_name')

    -- 序列使用
    select currval('custom.usercnf_id_seq');
    select nextval('custom.usercnf_id_seq');
    SELECT setval('custom.usercnf_id_seq', new_val); 
    -- 序列重置
    ALTER SEQUENCE seq_name RESTART WITH new_val;

    -- 外键信息
    SELECT
        tc.table_schema, 
        tc.constraint_name, 
        tc.table_name, 
        kcu.column_name, 
        ccu.table_schema AS foreign_table_schema,
        ccu.table_name AS foreign_table_name,
        ccu.column_name AS foreign_column_name 
    FROM 
        information_schema.table_constraints AS tc 
        JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
        JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
    WHERE tc.constraint_type = 'FOREIGN KEY';

    -- 清理表空间
    vacuum table_name

    -- 文件ID和数据库数据关系
    SELECT *
    FROM pg_class
    WHERE pg_relation_filenode(oid) IN ();

    -- 所有表大小
    SELECT t.table_schema || '."' || t.table_name || '"' table_name,
    pg_size_pretty(pg_total_relation_size((t.table_schema || '."' || t.table_name || '"')::regclass)) table_total_size,
    pg_size_pretty(pg_table_size((t.table_schema || '."' || t.table_name || '"')::regclass)) table_size,
    pg_size_pretty(pg_relation_size((t.table_schema || '."' || t.table_name || '"')::regclass)) table_rel_size,
    pg_size_pretty(pg_indexes_size((t.table_schema || '."' || t.table_name || '"')::regclass)) indexes_size,
    pg_total_relation_size((t.table_schema || '."' || t.table_name || '"')::regclass) table_byte
    FROM information_schema.tables t
    ORDER BY table_byte DESC;

    -- 所有表使用序列
    SELECT seq_ns.nspname,
       seq.relname,
       tab_ns.nspname,
       tab.relname
    FROM pg_class seq
    JOIN pg_namespace seq_ns on seq.relnamespace = seq_ns.oid
    JOIN pg_depend d ON d.objid = seq.oid AND d.deptype = 'a' 
    JOIN pg_class tab ON d.refobjid = tab.oid
    JOIN pg_namespace tab_ns on tab.relnamespace = tab_ns.oid
    WHERE seq.relkind = 'S';

    -- 复制 template0 创建 dbname
    CREATE DATABASE dbname TEMPLATE template0;

    -- 临时表, 存在于Session中
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_ct(table_name varchar(200), table_ct int4);

    -- 数据库扩展
    SELECT * FROM pg_available_extensions;
    -- 数据库碎片信息
    CREATE EXTENSION pgstattuple;
    --    SELECT * FROM pgstattuple(regclass);
    --        table_len: Physical relation length in bytes
    --        tuple_count: Number of live tuples
    --        tuple_len: Total length of live tuples in bytes
    --        tuple_percent: Percentage of live tuples
    --        dead_tuple_count: Number of dead tuples
    --        dead_tuple_len: Total length of dead tuples in bytes
    --        dead_tuple_percent: Percentage of dead tuples
    --        free_space: Total free space in bytes
    --        free_percent: Percentage of free space
    --    SELECT * FROM pgstatindex(regclass);
    --        version:B-tree version number
    --        tree_level: Tree level of the root page
    --        index_size: Total index size in bytes
    --        root_block_no: Location of root page (zero if none)
    --        internal_pages: Number of "internal" (upper-level) pages
    --        leaf_pages: Number of leaf pages
    --        empty_pages:Number of empty pages
    --        deleted_pages: Number of deleted pages
    --        avg_leaf_density: Average density of leaf pages
    --        leaf_fragmentation: Leaf page fragmentation
    -- 行转列
    CREATE EXTENSION tablefunc;
    --    SELECT * FROM crosstab('...') AS ct(row_name text, category_1 text, category_2 text);
    -- 跨数据库连接
    CREATE EXTENSION postgres_fdw;
    --    CREATE SERVER foreign_server
    --        FOREIGN DATA WRAPPER postgres_fdw
    --        OPTIONS (host 'foreign_ip', port 'foreign_port', dbname 'foreign_db');
    --    ALTER SERVER foreign_server
    --        OPTIONS (SET host 'foreign_ip');
    --    CREATE USER MAPPING FOR local_user
    --        SERVER foreign_server
    --        OPTIONS (user 'foreign_user', password 'password');
    --    DROP SCHEMA IF EXISTS local_schema_name CASCADE; 
    --    CREATE SCHEMA local_schema_name ;
    --    IMPORT FOREIGN SCHEMA foreign_sechema
    --        FROM SERVER foreign_server INTO local_schema;
    -- 数据库行锁信息
    CREATE EXTENSION pgrowlocks;
    --    SELECT * FROM pgrowlocks(text)
    --        locked_row: tid
    --        locker: xid
    --        multi: is multitransaction
    --        modes: Key Share, Share, For No Key Update, No Key Update, For Update, Update
    --        pid: PID
    -- 数据库统计信息
    CREATE EXTENSION pg_stat_statements;

    -- 数据库死锁问题
    SELECT
        PID,
        NOW() - pg_stat_activity.query_start AS duration,
        query,
        state
    FROM pg_stat_activity
    WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes';

    SELECT blocked_locks.pid     AS blocked_pid,
        blocked_activity.usename  AS blocked_user,
        blocking_locks.pid     AS blocking_pid,
        blocking_activity.usename AS blocking_user,
        blocked_activity.query    AS blocked_statement,
        blocking_activity.query   AS current_statement_in_blocking_process
    FROM  pg_catalog.pg_locks         blocked_locks
    JOIN pg_catalog.pg_stat_activity blocked_activity  ON blocked_activity.pid = blocked_locks.pid
    JOIN pg_catalog.pg_locks         blocking_locks ON blocking_locks.locktype = blocked_locks.locktype
    AND blocking_locks.database IS NOT DISTINCT FROM blocked_locks.database
    AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
    AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
    AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
    AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
    AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
    AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
    AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
    AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
    AND blocking_locks.pid != blocked_locks.pid
    JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
   WHERE NOT blocked_locks.granted;

    -- 结束进程
    --          SELECT pg_cancel_backend(PID);
    --          SELECT pg_terminate_backend(PID);

    -- pg_stat_activity: 连接信息
    --          datid:
    --          datname: database name
    --          pid
    --          usename: user name
    --          application_name
    --          query:
    --          xact_start: current transaction was started
    --          query_start: currently active query was started
    --          state: active = executing a query, idle = waiting for a new client command, idle in transaction, idle in transaction (aborted), fastpath function call: executing a fast-path function, disabled: track_activities is disabled in this backend.
    --          wait_event_type: Lock = waiting for a heavyweight lock, LWLock = waiting for a lightweight lock
    --          client_addr
    --          client_hostname
    --          client_port
    -- postgreSQL 系统信息表
    -- information_schema:
    --          information_schema.tables: 当前数据包含的tables, view
    --                  table_catalog： database
    --                  table_schema
    --                  table_name
    --                  table_type: Base Table View
    --          information_schema.columns: 当前数据库表包含的columns
    --                  table_catalog
    --                  table_schema
    --                  table_name
    --                  column_name
    --                  data_type
    --          information_schema.triggers: 当前数据库triggers
    --                  trigger_catalog: database
    --                  trigger_schema
    --                  trigger_name
    --                  event_manipulation: INSERT, UPDATE, or DELETE
    --                  event_object_catalog: 目标数据库
    --                  event_object_schema: 目标模式
    --                  event_object_table: 目标表名
    --                  action_order
    --                  action_statement
    --          information_schema.table_constraints: 表约束信息
    --                  constraint_catalog: database
    --                  constraint_schema
    --                  constraint_name
    --                  table_catalog
    --                  table_schema
    --                  table_name
    --                  constraint_type: CHECK, FOREIGN KEY, PRIMARY KEY, UNIQUE
    --          information_schema.constraint_column_usage: 约束字段引用表
    --                  table_catalog
    --                  table_schema
    --                  table_name
    --                  column_name
    --                  constraint_name: (table_constraints.constraint_name)
    --          information_schema.key_column_usage: 约束字段表
    --                  constraint_name: (table_constraints.constraint_name)
    --                  column_name: 约束字段
    -- pg_catalog:
    --          pg_catalog.pg_class: 数据库基础信息(表、视图)
    --                  oid:
    --                  relname: real name 
    --                  relnamespace: namespace
    --                  relfilenode: real file node(Base目录下实际节点名称)
    --                  reltablespace: (pg_tablespace.oid)
    --                  relkind: 类型 r = ordinary table, i = index, S = sequence, t = TOAST table, v = view, m = materialized view, c = composite type, f = foreign table, p = partitioned table, I = partitioned index
    --          pg_catalog.pg_inherits: 表继承关系
    --                  inhrelid: (pg_class.oid) child table oid, 子表oid
    --                  inhparent: (pg_class.oid) parent table oid, 父表oid
    --          pg_catalog.pg_depend: 数据库字段间依赖
    --                  objid: (pg_class.oid)  The OID of the specific dependent object, 依赖对象的 OID
    --                  refobjid: (pg_class.oid)  The OID of the specific referenced object, 被引用对象的 OID
    --                  deptype: 依赖关系
    --                      DEPENDENCY_NORMAL (n)
    --                      DEPENDENCY_AUTO (a)
    --                      DEPENDENCY_INTERNAL (i)
    --                      DEPENDENCY_PARTITION_PRI (P)
    --                      DEPENDENCY_PARTITION_SEC (S)
    --                      DEPENDENCY_EXTENSION (e)
    --                      DEPENDENCY_AUTO_EXTENSION (x)
    --                      DEPENDENCY_PIN (p)
    --          pg_catalog.pg_proc: 函数、存储过程信息
    --                  oid
    --                  proname: proc name
    --                  prolang: (pg_language.oid)
    --                  prokind: f = a normal function, p = a procedure, a = an aggregate function, w = a window function
    --                  prosrc: actual source code of the function
    --                  proargnames: an array of the names of the function arguments
    --                  proargtypes: an array of the data types of the function arguments
    --          pg_catalog.pg_aggregate: 聚合函数信息表
    --                  aggfnoid: (pg_proc.oid)
    --                  aggtransfn
    --                  aggtranstype
    --                  aggfinalfn
    --                  agginitval
    --          pg_catalog.pg_trigger: 触发器信息
    --                  tgrelid: (pg_class.oid)
    --                  tgfoid: (pg_proc.oid)
    --                  tgname:
    --                  tgenabled: D: Disabled O: Enabled 
    --          pg_catalog.pg_locks: 锁信息
    --                  locktype: relation, extend, frozenid, page, tuple, transactionid, virtualxid, spectoken, object, userlock, or advisory
    --                  database: (pg_database.oid)
    --                  relation: (pg_class.oid)
    --                  transactionid:
    --                  mode: 
    --                  granted: True if lock is held, false if lock is awaited
    --                  pid: (pg_stat_activity.pid)
    --          pg_catalog.pg_cast
    --                  oid
    --                  castsource (pg_type.oid): ::regtype
    --                  casttarget (pg_type.oid): ::regtype
    --                  castfunc  (pg_proc.oid): ::regproc
    --                  castcontext: e explicit i implicitly a implicitly
    --          pg_catalog.pg_operator
    --                  oid
    --                  oprname
    --                  oprleft: pg_type.oid 左操作数的类型
    --                  oprright: pg_type.oid 右操作数的类型
    --                  oprresult: pg_type.oid 结果类型
    --                  oprcode: pg_proc.oid 实现这个操作符的函数
    --          pg_catalog.pg_constraint
    --                  oid
    --                  contype: c = check constraint, f = foreign key constraint, p = primary key constraint, u = unique constraint, t = constraint trigger, x = exclusion constraint
    --                  conrelid (pg_class.oid)
    -- oid转为可读字符串
    --      oid::regproc
    --      oid::regprocedure
    --      oid::regclass
    --      oid::regtype
    -- pg命令
    -- 备份
    pg_dump options DB_NAME
    -- options:
    --          --host=host  --port=port --username=username  --password
    --          --clean  --if-exists  --create
    --          --column-inserts  --attribute-inserts  --inserts
    --          --format=format: format: p-plain(psql) c-custom(pg_restore) d-directory(pg_restore) t-tar(pg_restore)
    --          --schema=pattern  --exclude-schema=pattern  --table=pattern  --exclude-table=pattern
    --          --schema-only  --data-only --disable-triggers
    --          --verbose
    --          --file=file_name
    pg_dump --port=PORT --host=HOST --username=USER --password --format=c --data-only --disable-triggers --table=table_name --file=/path/to/file.dump db_name

    pg_dump --port=PORT --host=HOST --username=USER --password --format=p --inserts --data-only --disable-triggers --table=table_name --file=/path/to/file.sql db_name
    -- 恢复
    pg_restore options FILE_NAME
    -- options:
    --          --host=host  --port=port --username=username --password  --dbname=dbname
    --          --clean  --if-exists  --create
    --          --format=format: format: c-custom(pg_restore) d-directory(pg_restore) t-tar(pg_restore)
    --          --schema-only --data-only --disable-triggers
    pg_restore --port=PORT --host=HOST --username=USER --password --format=c --disable-triggers --dbname=dbname /path/to/file.dump
    psql options
    -- options:
    --          --host=host  --port=port  --password  --dbname=dbname
    --          --file=filename
    psql --port=PORT --host=HOST --username=USER --password  --dbname=db_name --file=/path/to/file.sql
    -- 启动、关闭
    pg_ctl [-o '-p 8888'] -D datadir start / stop
    -- 初始化数据库
    initdb [option...] [--pgdata | -D] directory
    -- options:
    --          --username=username
    --          --pwprompt
    -- pgcompacttable: 表压缩
    ```
