-- 创建第一, 第二数据库
CREATE DATABASE IF NOT EXISTS `primary`;

CREATE DATABASE IF NOT EXISTS `secondary`;

-- 创建Quartz专用数据库
CREATE DATABASE IF NOT EXISTS `quartz`;

-- 创建nacos专用数据库
CREATE DATABASE IF NOT EXISTS `nacos`;

-- 创建zipkin专用数据库
CREATE DATABASE IF NOT EXISTS `zipkin`;

-- 创建用户并授权
CREATE USER 'china' @'%' IDENTIFIED BY 'chinese';

CREATE USER 'nacos' @'%' IDENTIFIED BY 'nacos';

CREATE USER 'zipkin' @'%' IDENTIFIED BY 'zipkin';

GRANT ALL PRIVILEGES ON *.* TO 'china' @'%' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON nacos.* TO 'nacos' @'%' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON zipkin.* TO 'zipkin' @'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

-- 创建必须表和数据
USE primary;

CREATE TABLE who_am_i(
    id TINYINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL COMMENT '当前数据库名称'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '当前数据库名表';

CREATE TABLE user(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    account VARCHAR(20) NOT NULL COMMENT '用户账户',
    `password` VARCHAR(50) NOT NULL COMMENT '用户密码',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '用户表';

CREATE TABLE role(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20) NOT NULL COMMENT '角色代码',
    name VARCHAR(20) NOT NULL COMMENT '角色名称',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '角色表';

CREATE TABLE permission(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20) NOT NULL COMMENT '权限代码',
    name VARCHAR(20) NOT NULL COMMENT '权限名称',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '权限表';

CREATE TABLE schedule_job(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    target_bean VARCHAR(200) NOT NULL COMMENT 'spring bean名称',
    target_method VARCHAR(200) NOT NULL COMMENT 'spring bean方法',
    target_argument VARCHAR(2000) DEFAULT NULL COMMENT '方法参数',
    cron_expression VARCHAR(100) DEFAULT NULL COMMENT 'cron表达式',
    schedule_type TINYINT NOT NULL COMMENT '定时任务类型: 1-spring 2-quartz',
    schedule_status TINYINT NOT NULL COMMENT '任务状态: 0-正常 1-暂停 2-删除',
    remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '定时任务';

CREATE TABLE join_table(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    table_a_name VARCHAR(50) NOT NULL COMMENT '表A名称',
    table_a_id BIGINT NOT NULL COMMENT '表A对应ID',
    table_b_name VARCHAR(50) NOT NULL COMMENT '表B名称',
    table_b_id BIGINT NOT NULL COMMENT '表B对应ID',
    INDEX(
        table_a_name,
        table_a_id,
        table_b_name,
        table_b_id
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '表与表关联中间表';

INSERT INTO
    who_am_i (name) VALUE ('primary');

INSERT INTO
    user(id, account, `password`, create_time) VALUE (1, 'china', 'chinese', '2020-06-29');

INSERT INTO
    role(id, code, name, create_time) VALUE (1, 'general', '通用角色', '2020-06-29');

INSERT INTO
    permission(id, code, name, create_time) VALUE (1, 'v1:token:authc', '权限-测试token', '2020-06-29');

INSERT INTO
    join_table(
        table_a_name,
        table_a_id,
        table_b_name,
        table_b_id
    ) VALUE ('user', 1, 'role', 1);

INSERT INTO
    join_table(
        table_a_name,
        table_a_id,
        table_b_name,
        table_b_id
    ) VALUE ('role', 1, 'permission', 1);

COMMIT;

USE secondary;

CREATE TABLE who_am_i(
    id TINYINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL COMMENT '当前数据库名称'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '当前数据库名表';

INSERT INTO
    who_am_i (name) VALUE ('secondary');

COMMIT;

-- 创建Quartz表
USE quartz;

CREATE TABLE who_am_i(
    id TINYINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL COMMENT '当前数据库名称'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '当前数据库名表';

CREATE TABLE QRTZ_JOB_DETAILS(
    SCHED_NAME VARCHAR(120) NOT NULL,
    JOB_NAME VARCHAR(190) NOT NULL,
    JOB_GROUP VARCHAR(190) NOT NULL,
    `DESCRIPTION` VARCHAR(250) NULL,
    JOB_CLASS_NAME VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME, JOB_NAME, JOB_GROUP)
);

CREATE TABLE QRTZ_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(190) NOT NULL,
    TRIGGER_GROUP VARCHAR(190) NOT NULL,
    JOB_NAME VARCHAR(190) NOT NULL,
    JOB_GROUP VARCHAR(190) NOT NULL,
    `DESCRIPTION` VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    `PRIORITY` INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(190) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, JOB_NAME, JOB_GROUP) REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME, JOB_NAME, JOB_GROUP)
);

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(190) NOT NULL,
    TRIGGER_GROUP VARCHAR(190) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(10) NOT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CRON_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(190) NOT NULL,
    TRIGGER_GROUP VARCHAR(190) NOT NULL,
    CRON_EXPRESSION VARCHAR(120) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_SIMPROP_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(190) NOT NULL,
    TRIGGER_GROUP VARCHAR(190) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13, 4) NULL,
    DEC_PROP_2 NUMERIC(13, 4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_BLOB_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(190) NOT NULL,
    TRIGGER_GROUP VARCHAR(190) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    INDEX (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CALENDARS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    CALENDAR_NAME VARCHAR(190) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (SCHED_NAME, CALENDAR_NAME)
);

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_GROUP VARCHAR(190) NOT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_FIRED_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(190) NOT NULL,
    TRIGGER_GROUP VARCHAR(190) NOT NULL,
    INSTANCE_NAME VARCHAR(190) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    SCHED_TIME BIGINT(13) NOT NULL,
    `PRIORITY` INTEGER NOT NULL,
    `STATE` VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(190) NULL,
    JOB_GROUP VARCHAR(190) NULL,
    IS_NONCONCURRENT VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME, ENTRY_ID)
);

CREATE TABLE QRTZ_SCHEDULER_STATE (
    SCHED_NAME VARCHAR(120) NOT NULL,
    INSTANCE_NAME VARCHAR(190) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (SCHED_NAME, INSTANCE_NAME)
);

CREATE TABLE QRTZ_LOCKS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME VARCHAR(40) NOT NULL,
    PRIMARY KEY (SCHED_NAME, LOCK_NAME)
);

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME, REQUESTS_RECOVERY);

CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME, JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME, JOB_NAME, JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME, JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME, CALENDAR_NAME);

CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_GROUP);

CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(
    SCHED_NAME,
    TRIGGER_NAME,
    TRIGGER_GROUP,
    TRIGGER_STATE
);

CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME, NEXT_FIRE_TIME);

CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);

CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);

CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(
    SCHED_NAME,
    MISFIRE_INSTR,
    NEXT_FIRE_TIME,
    TRIGGER_STATE
);

CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(
    SCHED_NAME,
    MISFIRE_INSTR,
    NEXT_FIRE_TIME,
    TRIGGER_GROUP,
    TRIGGER_STATE
);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, INSTANCE_NAME);

CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);

CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, JOB_NAME, JOB_GROUP);

CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, JOB_GROUP);

CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME, TRIGGER_GROUP);

INSERT INTO
    who_am_i (name) VALUE ('quartz');

COMMIT;

-- nacos相关表
USE nacos;

CREATE TABLE config_info (
    id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    data_id varchar(255) NOT NULL COMMENT 'data_id',
    group_id varchar(255) DEFAULT NULL,
    content longtext NOT NULL COMMENT 'content',
    md5 varchar(32) DEFAULT NULL COMMENT 'md5',
    gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    src_user text COMMENT 'source user',
    src_ip varchar(20) DEFAULT NULL COMMENT 'source ip',
    app_name varchar(128) DEFAULT NULL,
    tenant_id varchar(128) DEFAULT '' COMMENT '租户字段',
    c_desc varchar(256) DEFAULT NULL,
    c_use varchar(64) DEFAULT NULL,
    effect varchar(64) DEFAULT NULL,
    type varchar(64) DEFAULT NULL,
    c_schema text,
    PRIMARY KEY (id),
    UNIQUE KEY uk_configinfo_datagrouptenant (data_id, group_id, tenant_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = 'config_info';

CREATE TABLE config_info_aggr (
    id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    data_id varchar(255) NOT NULL COMMENT 'data_id',
    group_id varchar(255) NOT NULL COMMENT 'group_id',
    datum_id varchar(255) NOT NULL COMMENT 'datum_id',
    content longtext NOT NULL COMMENT '内容',
    gmt_modified datetime NOT NULL COMMENT '修改时间',
    app_name varchar(128) DEFAULT NULL,
    tenant_id varchar(128) DEFAULT '' COMMENT '租户字段',
    PRIMARY KEY (id),
    UNIQUE KEY uk_configinfoaggr_datagrouptenantdatum (data_id, group_id, tenant_id, datum_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段';

CREATE TABLE config_info_beta (
    id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    data_id varchar(255) NOT NULL COMMENT 'data_id',
    group_id varchar(128) NOT NULL COMMENT 'group_id',
    app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
    content longtext NOT NULL COMMENT 'content',
    beta_ips varchar(1024) DEFAULT NULL COMMENT 'betaIps',
    md5 varchar(32) DEFAULT NULL COMMENT 'md5',
    gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    src_user text COMMENT 'source user',
    src_ip varchar(20) DEFAULT NULL COMMENT 'source ip',
    tenant_id varchar(128) DEFAULT '' COMMENT '租户字段',
    PRIMARY KEY (id),
    UNIQUE KEY uk_configinfobeta_datagrouptenant (data_id, group_id, tenant_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta';

CREATE TABLE config_info_tag (
    id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    data_id varchar(255) NOT NULL COMMENT 'data_id',
    group_id varchar(128) NOT NULL COMMENT 'group_id',
    tenant_id varchar(128) DEFAULT '' COMMENT 'tenant_id',
    tag_id varchar(128) NOT NULL COMMENT 'tag_id',
    app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
    content longtext NOT NULL COMMENT 'content',
    md5 varchar(32) DEFAULT NULL COMMENT 'md5',
    gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    src_user text COMMENT 'source user',
    src_ip varchar(20) DEFAULT NULL COMMENT 'source ip',
    PRIMARY KEY (id),
    UNIQUE KEY uk_configinfotag_datagrouptenanttag (data_id, group_id, tenant_id, tag_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag';

CREATE TABLE config_tags_relation (
    id bigint(20) NOT NULL COMMENT 'id',
    tag_name varchar(128) NOT NULL COMMENT 'tag_name',
    tag_type varchar(64) DEFAULT NULL COMMENT 'tag_type',
    data_id varchar(255) NOT NULL COMMENT 'data_id',
    group_id varchar(128) NOT NULL COMMENT 'group_id',
    tenant_id varchar(128) DEFAULT '' COMMENT 'tenant_id',
    nid bigint(20) NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (nid),
    UNIQUE KEY uk_configtagrelation_configidtag (id, tag_name, tag_type),
    KEY idx_tenant_id (tenant_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation';

CREATE TABLE group_capacity (
    id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    group_id varchar(128) NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
    quota int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
    `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
    `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
    max_aggr_count int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
    max_aggr_size int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
    max_history_count int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
    gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表';

CREATE TABLE his_config_info (
    id bigint(64) unsigned NOT NULL,
    nid bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    data_id varchar(255) NOT NULL,
    group_id varchar(128) NOT NULL,
    app_name varchar(128) DEFAULT NULL COMMENT 'app_name',
    content longtext NOT NULL,
    md5 varchar(32) DEFAULT NULL,
    gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    src_user text,
    src_ip varchar(20) DEFAULT NULL,
    op_type char(10) DEFAULT NULL,
    tenant_id varchar(128) DEFAULT '' COMMENT '租户字段',
    PRIMARY KEY (nid),
    KEY idx_gmt_create (gmt_create),
    KEY idx_gmt_modified (gmt_modified),
    KEY idx_did (data_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造';

CREATE TABLE tenant_capacity (
    id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    tenant_id varchar(128) NOT NULL DEFAULT '' COMMENT 'Tenant ID',
    quota int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
    `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
    `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
    max_aggr_count int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
    max_aggr_size int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
    max_history_count int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
    gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表';

CREATE TABLE tenant_info (
    id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    kp varchar(128) NOT NULL COMMENT 'kp',
    tenant_id varchar(128) default '' COMMENT 'tenant_id',
    tenant_name varchar(128) default '' COMMENT 'tenant_name',
    tenant_desc varchar(256) DEFAULT NULL COMMENT 'tenant_desc',
    create_source varchar(32) DEFAULT NULL COMMENT 'create_source',
    gmt_create bigint(20) NOT NULL COMMENT '创建时间',
    gmt_modified bigint(20) NOT NULL COMMENT '修改时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_tenant_info_kptenantid (kp, tenant_id),
    KEY idx_tenant_id (tenant_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info';

CREATE TABLE users (
    username varchar(50) NOT NULL PRIMARY KEY,
    `password` varchar(500) NOT NULL,
    `enabled` boolean NOT NULL
);

CREATE TABLE roles (
    username varchar(50) NOT NULL,
    role varchar(50) NOT NULL,
    UNIQUE INDEX idx_user_role (username ASC, role ASC) USING BTREE
);

CREATE TABLE permissions (
    role varchar(50) NOT NULL,
    resource varchar(255) NOT NULL,
    action varchar(8) NOT NULL,
    UNIQUE INDEX uk_role_permission (role, resource, action) USING BTREE
);

INSERT INTO
    users (username, password, enabled)
VALUES
    (
        'nacos',
        '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',
        TRUE
    );

INSERT INTO
    roles (username, role)
VALUES
    ('nacos', 'ROLE_ADMIN');

-- zipkin
USE zipkin;

CREATE TABLE IF NOT EXISTS zipkin_spans (
    `trace_id_high` BIGINT NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
    `trace_id` BIGINT NOT NULL,
    `id` BIGINT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `remote_service_name` VARCHAR(255),
    `parent_id` BIGINT,
    `debug` BIT(1),
    `start_ts` BIGINT COMMENT 'Span.timestamp(): epoch micros used for endTs query and to implement TTL',
    `duration` BIGINT COMMENT 'Span.duration(): micros used for minDuration and maxDuration query',
    PRIMARY KEY (`trace_id_high`, `trace_id`, `id`)
) ENGINE = InnoDB ROW_FORMAT = COMPRESSED CHARACTER SET = utf8 COLLATE utf8_general_ci;

ALTER TABLE
    zipkin_spans
ADD
    INDEX(`trace_id_high`, `trace_id`) COMMENT 'for getTracesByIds';

ALTER TABLE
    zipkin_spans
ADD
    INDEX(`name`) COMMENT 'for getTraces and getSpanNames';

ALTER TABLE
    zipkin_spans
ADD
    INDEX(`remote_service_name`) COMMENT 'for getTraces and getRemoteServiceNames';

ALTER TABLE
    zipkin_spans
ADD
    INDEX(`start_ts`) COMMENT 'for getTraces ordering and range';

CREATE TABLE IF NOT EXISTS zipkin_annotations (
    `trace_id_high` BIGINT NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
    `trace_id` BIGINT NOT NULL COMMENT 'coincides with zipkin_spans.trace_id',
    `span_id` BIGINT NOT NULL COMMENT 'coincides with zipkin_spans.id',
    `a_key` VARCHAR(255) NOT NULL COMMENT 'BinaryAnnotation.key or Annotation.value if type == -1',
    `a_value` BLOB COMMENT 'BinaryAnnotation.value(), which must be smaller than 64KB',
    `a_type` INT NOT NULL COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
    `a_timestamp` BIGINT COMMENT 'Used to implement TTL; Annotation.timestamp or zipkin_spans.timestamp',
    `endpoint_ipv4` INT COMMENT 'Null when Binary/Annotation.endpoint is null',
    `endpoint_ipv6` BINARY(16) COMMENT 'Null when Binary/Annotation.endpoint is null, or no IPv6 address',
    `endpoint_port` SMALLINT COMMENT 'Null when Binary/Annotation.endpoint is null',
    `endpoint_service_name` VARCHAR(255) COMMENT 'Null when Binary/Annotation.endpoint is null'
) ENGINE = InnoDB ROW_FORMAT = COMPRESSED CHARACTER SET = utf8 COLLATE utf8_general_ci;

ALTER TABLE
    zipkin_annotations
ADD
    UNIQUE KEY(
        `trace_id_high`,
        `trace_id`,
        `span_id`,
        `a_key`,
        `a_timestamp`
    ) COMMENT 'Ignore insert on duplicate';

ALTER TABLE
    zipkin_annotations
ADD
    INDEX(`trace_id_high`, `trace_id`, `span_id`) COMMENT 'for joining with zipkin_spans';

ALTER TABLE
    zipkin_annotations
ADD
    INDEX(`trace_id_high`, `trace_id`) COMMENT 'for getTraces/ByIds';

ALTER TABLE
    zipkin_annotations
ADD
    INDEX(`endpoint_service_name`) COMMENT 'for getTraces and getServiceNames';

ALTER TABLE
    zipkin_annotations
ADD
    INDEX(`a_type`) COMMENT 'for getTraces and autocomplete values';

ALTER TABLE
    zipkin_annotations
ADD
    INDEX(`a_key`) COMMENT 'for getTraces and autocomplete values';

ALTER TABLE
    zipkin_annotations
ADD
    INDEX(`trace_id`, `span_id`, `a_key`) COMMENT 'for dependencies job';

CREATE TABLE IF NOT EXISTS zipkin_dependencies (
    `day` DATE NOT NULL,
    `parent` VARCHAR(255) NOT NULL,
    `child` VARCHAR(255) NOT NULL,
    `call_count` BIGINT,
    `error_count` BIGINT,
    PRIMARY KEY (`day`, `parent`, `child`)
) ENGINE = InnoDB ROW_FORMAT = COMPRESSED CHARACTER SET = utf8 COLLATE utf8_general_ci;