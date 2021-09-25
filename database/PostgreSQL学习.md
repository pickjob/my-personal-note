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

    -- PG一些限制
    max_locks_per_transaction:
        max_locks_per_transaction * (max_connections + max_prepared_transactions)
    max_pred_locks_per_transaction:
        max_pred_locks_per_transaction * (max_connections + max_prepared_transactions) 

    -- pg特殊配置
    set zero_damaged_pages = true;
    show zero_damaged_pages; 

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
    CREATE EXTENSION pgstattuple;

    -- 数据库死锁问题
    SELECT
        PID,
        NOW() - pg_stat_activity.query_start AS duration,
        query,
        state
    FROM pg_stat_activity
    WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes';

    SELECT 
        waiting.locktype           AS waiting_locktype,
        waiting.relation::regclass AS waiting_table,
        waiting_stm.query          AS waiting_query,
        waiting.mode               AS waiting_mode,
        waiting.pid                AS waiting_pid,
        other.locktype             AS other_locktype,
        other.relation::regclass   AS other_table,
        other_stm.query            AS other_query,
        other.mode                 AS other_mode,
        other.pid                  AS other_pid,
        other.granted              AS other_granted
    FROM
        pg_catalog.pg_locks AS waiting
    JOIN
        pg_catalog.pg_stat_activity AS waiting_stm
        ON (
            waiting_stm.pid = waiting.pid
        )
    JOIN
        pg_catalog.pg_locks AS other
        ON (
            (
                waiting."database" = other."database"
            AND waiting.relation  = other.relation
            )
            OR waiting.transactionid = other.transactionid
        )
    JOIN
        pg_catalog.pg_stat_activity AS other_stm
        ON (
            other_stm.pid = other.pid
        )
    WHERE
        NOT waiting.granted
    AND
        waiting.pid <> other.pid

    CREATE OR REPLACE VIEW blocking_tree AS
    WITH RECURSIVE
    lock AS (
    SELECT pid,
        virtualtransaction,
        granted,
        mode,
        (locktype,
        CASE locktype
        WHEN 'relation'      THEN concat_ws(';', 'db:'||datname, 'rel:'||relation::regclass::text)
        WHEN 'extend'        THEN concat_ws(';', 'db:'||datname, 'rel:'||relation::regclass::text)
        WHEN 'page'          THEN concat_ws(';', 'db:'||datname, 'rel:'||relation::regclass::text, 'page#'||page::text)
        WHEN 'tuple'         THEN concat_ws(';', 'db:'||datname, 'rel:'||relation::regclass::text, 'page#'||page::text, 'tuple#'||tuple::text)
        WHEN 'transactionid' THEN transactionid::text
        WHEN 'virtualxid'    THEN virtualxid::text
        WHEN 'object'        THEN concat_ws(';', 'class:'||classid::regclass::text, 'objid:'||objid, 'col#'||objsubid)
        ELSE concat('db:'||datname) -- userlock and advisory
        END::text) AS target
    FROM pg_catalog.pg_locks
    LEFT JOIN pg_catalog.pg_database ON (pg_database.oid = pg_locks.database)
    )
    , waiting_lock AS (
    SELECT
        blocker.pid                         AS blocker_pid,
        blocked.pid                         AS pid,
        concat(blocked.mode,blocked.target) AS lock_target
    FROM lock blocker
    JOIN lock blocked
        ON ( NOT blocked.granted
        AND blocker.granted
        AND blocked.pid != blocker.pid
        AND blocked.target IS NOT DISTINCT FROM blocker.target)
    JOIN lock_composite c ON (c.requested = blocked.mode AND c.current = blocker.mode)
    )
    , acquired_lock AS (
    WITH waiting AS (
        SELECT lock_target, count(lock_target) AS wait_count FROM waiting_lock GROUP BY lock_target
    )
    SELECT
        pid,
        array_agg(concat(mode,target,' + '||wait_count) ORDER BY wait_count DESC NULLS LAST) AS locks_acquired
    FROM lock
        LEFT JOIN waiting ON waiting.lock_target = concat(mode,target)
    WHERE granted
    GROUP BY pid
    )
    , blocking_lock AS (
    SELECT
        ARRAY[date_part('epoch', query_start)::int, pid] AS seq,
        0::int AS depth,
        -1::int AS blocker_pid,
        pid,
        concat('Connect: ',usename,' ',datname,' ',coalesce(host(client_addr)||':'||client_port, 'local')
        , E'\nSQL: ',replace(substr(coalesce(query,'N/A'), 1, 60), E'\n', ' ')
        , E'\nAcquired:\n  '
        , array_to_string(locks_acquired[1:5] ||
                            CASE WHEN array_upper(locks_acquired,1) > 5
                                THEN '... '||(array_upper(locks_acquired,1) - 5)::text||' more ...'
                            END,
                            E'\n  ')
        ) AS lock_info,
        concat(to_char(query_start, CASE WHEN age(query_start) > '24h' THEN 'Day DD Mon' ELSE 'HH24:MI:SS' END),E' started\n'
            ,CASE WHEN waiting THEN 'waiting' ELSE state END,E'\n'
            ,date_trunc('second',age(now(),query_start)),' ago'
        ) AS lock_state
    FROM acquired_lock blocker
    LEFT JOIN pg_stat_activity act USING (pid)
    WHERE EXISTS     -- The root of the tree should blocks one or more sessions.
            (SELECT 'x' FROM waiting_lock blocked WHERE blocked.blocker_pid = blocker.pid)
        AND NOT EXISTS -- The root of the tree should not be a blocked session.
            (SELECT 'x' FROM waiting_lock blocked WHERE blocked.pid = blocker.pid)
    UNION ALL
    SELECT
        blocker.seq || blocked.pid,
        blocker.depth + 1,
        blocker.pid,
        blocked.pid,
        concat('Connect: ',usename,' ',datname,' ',coalesce(host(client_addr)||':'||client_port, 'local')
        , E'\nSQL: ',replace(substr(coalesce(query,'N/A'), 1, 60), E'\n', ' ')
        , E'\nWaiting: ',blocked.lock_target
        , CASE WHEN locks_acquired IS NOT NULL
                THEN E'\nAcquired:\n  ' ||
                    array_to_string(locks_acquired[1:5] ||
                                    CASE WHEN array_upper(locks_acquired,1) > 5
                                        THEN '... '||(array_upper(locks_acquired,1) - 5)::text||' more ...'
                                    END,
                                    E'\n  ')
            END
        ) AS lock_info,
        concat(to_char(query_start, CASE WHEN age(query_start) > '24h' THEN 'Day DD Mon' ELSE 'HH24:MI:SS' END),E' started\n'
            ,CASE WHEN waiting THEN 'waiting' ELSE state END,E'\n'
            ,date_trunc('second',age(now(),query_start)),' ago'
        ) AS lock_state
    FROM blocking_lock blocker
    JOIN waiting_lock blocked
        ON (blocked.blocker_pid = blocker.pid)
    LEFT JOIN pg_stat_activity act ON (act.pid = blocked.pid)
    LEFT JOIN acquired_lock acq ON (acq.pid = blocked.pid)
    WHERE blocker.depth < 5
    )
    SELECT concat(lpad('=> ', 4*depth, ' '),pid::text) AS "PID"
    , lock_info AS "Lock Info"
    , lock_state AS "State"
    FROM blocking_lock
    ORDER BY seq;

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
    --          pgstattuple插件
    --              SELECT * FROM pgstattuple(regclass);
    --                  table_len: Physical relation length in bytes
    --                  tuple_count: Number of live tuples
    --                  tuple_len: Total length of live tuples in bytes
    --                  tuple_percent: Percentage of live tuples
    --                  dead_tuple_count: Number of dead tuples
    --                  dead_tuple_len: Total length of dead tuples in bytes
    --                  dead_tuple_percent: Percentage of dead tuples
    --                  free_space: Total free space in bytes
    --                  free_percent: Percentage of free space
    --              SELECT * FROM pgstatindex(regclass);
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
    pg_restore --port=PORT --host=HOST --username=USER --password --format=c --data-only --disable-triggers --table=table_name --dbname=db_name /path/to/file.dump
    psql options
    -- options:
    --          --host=host  --port=port  --password  --dbname=dbname
    --          --file=filename
    psql --port=PORT --host=HOST --username=USER --password --file=/path/to/file.sql --dbname=db_name
    -- 启动、关闭
    pg_ctl start / stop -D datadir

    -- pgcompacttable: 表压缩
    ```
