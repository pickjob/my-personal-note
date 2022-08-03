```sql
CREATE OR REPLACE FUNCTION somefunc(integer, text)
RETURNS integer
-- 返回多个值： TABLE(quantity int, total numeric)
-- SETOF sometype
AS $$
[ <<label>> ]
[ DECLARE declarations ]
-- 声明语法:
--      name [ CONSTANT ] type [ COLLATE collation_name ] [ NOT NULL ] [ { DEFAULT | := | = } expression ];
-- 声明参数别名($1、$2):
--      name ALIAS FOR $n;
-- 行类型
--      name table_name%ROWTYPE;
-- 记录类型
--      name RECORD;
-- 游标
--      name [ [ NO ] SCROLL ] CURSOR [ ( arguments ) ] FOR query;
BEGIN
    statements
    -- 赋值: variable { := | = } expression;
    -- 丢弃结果: PERFORM query
    -- 单一行结果:
    --      SELECT select_expressions INTO target FROM ...;
    --      INSERT ... RETURNING expressions INTO [STRICT] target;
    --      UPDATE ... RETURNING expressions INTO [STRICT] target;
    --      DELETE ... RETURNING expressions INTO [STRICT] target;
    -- EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ]; $1 $2: 执行动态sql
    EXECUTE 'SELECT count(*) FROM '
                || quote_ident(tabname)
                || ' WHERE inserted_by = $1 AND inserted <= $2'
            INTO c
            USING checked_user, checked_date;
    -- IF:
    --      IF boolean-expression THEN
    --          statements
    --      [ ELSIF boolean-expression THEN
    --          statements
    --      [ ELSIF boolean-expression THEN
    --          statements
    --          ...
    --      ]
    --      ]
    --      [ ELSE
    --          statements ]
    --      END IF;
    -- CASE
    --      CASE search-expression
    --          WHEN expression [, expression [ ... ]] THEN
    --              statements
    --          [ WHEN expression [, expression [ ... ]] THEN
    --              statements
    --          ... ]
    --          [ ELSE
    --              statements ]
    --      END CASE;
    -- LOOP
    --      [ <<label>> ]
    --      LOOP
    --          statements
    --          EXIT [label]
    --          CONTINUE [label]
    --      END LOOP [ label ];
    -- WHILE
    --       WHILE:
    --        [ <<label>> ]
    --        WHILE boolean-expression LOOP
    --            statements
    --        END LOOP [ label ];
    -- FOR
    --        [ <<label>> ]
    --        FOR name IN [ REVERSE ] expression .. expression [ BY expression ]
    --        LOOP
    --            statements
    --        END LOOP [ label ];
    --        -- 遍历查询结果(DECLARE target RECORD)
    --        [ <<label>> ]
    --        FOR target IN query
    --        LOOP
    --            statements
    --        END LOOP [ label ];
    --        -- 数组迭代
    --        [ <<label>> ]
    --        FOREACH target [ SLICE number ] IN ARRAY expression LOOP
    --            statements
    --        END LOOP [ label ]
    -- 游标
    --      OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR query;
    --      FETCH [ direction { FROM | IN } ] cursor INTO target;
    --      CLOSE cursor;
END [ label ];
$$ LANGUAGE plpgsql
[ IMMUTABLE | STABLE | VOLATILE ] -- IMMUTABLE: 不改变数据库, 输入不变输出不变 VOLATILE: 改变数据库
[ RETURNS NULL ON NULL INPUT] -- 输入为NULL 输出为NULL
;

-- 触发器函数
CREATE OR REPLACE FUNCTION trigger_func()
RETURNS trigger
AS $tigger$
BEGIN
--  特殊变量
--      NEW: RECORD, 新数据行
--      OLD: RECORD, 老数据行
--      TG_NAME: NAME, 触发器名字
--      TG_WHEN: TEXT, BEFORE、AFTER、INSTEAD
--      TG_LEVEL: TEXT, ROW、STATEMENT
--      TG_OP: TEXT, INSERT、UPDATE、DELETE、TRUNCATE
--      TG_TABLE_NAME: NAME, 触发器表名
END
$tigger$ LANGUAGE plpgsql;

-- 操作符
CREATE OR REPLACE FUNCTION func_name(numeric, text)
RETURNS bool
AS $func$
DECLARE
    _result boolean;
BEGIN
    select pg_catalog.int4ge($1, $2::int) into _result;
    return _result;
END
$func$ LANGUAGE plpgsql;

CREATE OPERATOR >= (
    LEFTARG = numeric,
    RIGHTARG = text,
    PROCEDURE = func_name,
    COMMUTATOR = <=
);

-- 临时运行脚本
DO LANGUAGE plpgsql
$$
DECLARE _record RECORD;
DECLARE _tablename VARCHAR(200);
BEGIN
    FOR _record IN SELECT * FROM information_schema."tables" t
    LOOP
        _tablename = _record.table_name;
        RAISE NOTICE 'tablename: %', _tablename;
    END LOOP;
END $$;
```
